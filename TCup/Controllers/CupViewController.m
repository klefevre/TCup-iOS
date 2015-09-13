//
//  CupViewController.m
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "CupViewController.h"

#import "SocketService.h"

static CGFloat const kMinTemperature = 20.f;
static CGFloat const kMaxTemperature = 80.f;

typedef NS_ENUM(NSInteger, CupViewControllerStep) {
    CupViewControllerStepChooseTemperature,
    CupViewControllerStepChooseWaitGoodTemperature
};

@interface CupViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;

@property (nonatomic, weak) IBOutlet UIView *chooseTemperatureView; // container
@property (nonatomic, weak) IBOutlet UISlider *temperatureSlider;
@property (nonatomic, weak) IBOutlet UILabel *temperatureChosenLabel;

@property (nonatomic, weak) IBOutlet UIView *waitGoodTemperatureView; // container
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) IBOutlet UILabel *targetTempLabel;
@property (nonatomic, weak) IBOutlet UILabel *maxTempLabel;
@property (nonatomic, weak) IBOutlet UILabel *curTempLabel;

@property (nonatomic, assign) CupViewControllerStep step;

@end

@implementation CupViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.targetTempLabel.text = @"";
    self.maxTempLabel.text = @"";
    self.curTempLabel.text = @"";

    // Set slider value
    self.temperatureSlider.minimumValue = kMinTemperature;
    self.temperatureSlider.maximumValue = kMaxTemperature;
    self.temperatureSlider.value = (kMinTemperature + kMaxTemperature) / 2.f;
    self.temperatureChosenLabel.text = [NSString stringWithFormat:@"%.0f °C", self.temperatureSlider.value];

    __block CGFloat maxTemp = 0.1;
    @weakify(self);
    [[SocketService sharedInstance].socket on:@"celsius" callback:^(NSArray *args) {
        @strongify(self);
        NSNumber *tempNumber = [args firstObject];
        if (tempNumber != nil) {
            CGFloat temp = [tempNumber floatValue];
            if (temp > maxTemp) {
                maxTemp = temp;
                self.maxTempLabel.text = [NSString stringWithFormat:@"%.0f °C", maxTemp];
            }
            self.curTempLabel.text = [NSString stringWithFormat:@"%.0f °C", temp];
            self.progressView.progress = temp / maxTemp;
        }
        NSLog(@"args: %@", args);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter

- (void)setStep:(CupViewControllerStep)step {
    _step = step;

    switch (step) {
        case CupViewControllerStepChooseTemperature:
            break;
        case CupViewControllerStepChooseWaitGoodTemperature:
            self.waitGoodTemperatureView.alpha = 0.f;
            self.waitGoodTemperatureView.hidden = NO;
            [UIView transitionWithView:self.containerView
                              duration:0.7
                               options:UIViewAnimationOptionCurveEaseIn
                            animations:^{
                                self.chooseTemperatureView.alpha = 0.0;
                                self.waitGoodTemperatureView.alpha = 1.0;
                            }
                            completion:NULL];
            break;
    }
}

#pragma mark - Actions

- (IBAction)sliderValueChanged:(UISlider *)slider {
    self.temperatureChosenLabel.text = [NSString stringWithFormat:@"%.0f °C", slider.value];
}

- (IBAction)temperatureChoosen:(id)sender {
    self.targetTempLabel.text = [NSString stringWithFormat:@"%.0f °C", self.temperatureSlider.value];

    NSNumber *idealTemp = @(self.temperatureSlider.value);
    NSLog(@"ideal temperature is %@ -> sending to tcup", idealTemp);
    [[SocketService sharedInstance].socket emit:@"setMaxCelsius" args:@[idealTemp]];
    self.step = CupViewControllerStepChooseWaitGoodTemperature;
}

@end

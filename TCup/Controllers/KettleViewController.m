//
//  KettleViewController.m
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import "KettleViewController.h"
#import "Tea.h"
#import "SocketService.h"

static NSTimeInterval const kDurationSleep = 0.05;

@interface KettleViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;

@property (nonatomic, weak) IBOutlet UIView *boilView; // container
@property (nonatomic, weak) IBOutlet UILabel *minTempLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentTempLabel;
@property (nonatomic, weak) IBOutlet UILabel *targetTempLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *boilProgressView;
@property (nonatomic, weak) IBOutlet UIButton *infusionButton;

@property (nonatomic, weak) IBOutlet UIView *infusionView; // container
@property (nonatomic, weak) IBOutlet UILabel *infusionDelayMinLabel;
@property (nonatomic, weak) IBOutlet UILabel *infusionDelayMaxLabel;
@property (nonatomic, weak) IBOutlet UILabel *infusionCurrentLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *infusionProgressView;
@property (nonatomic, weak) IBOutlet UIButton *serveButton;

// boil
@property (nonatomic, assign) NSUInteger boilProgress;

// infusion
@property (nonatomic, assign) NSUInteger infusionProgress;

@end

@implementation KettleViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Boil
    self.infusionButton.alpha = 0.f;
    self.minTempLabel.text = @"0 °C";
    self.currentTempLabel.text = @"";
    self.targetTempLabel.text = [NSString stringWithFormat:@"%lu °C", (unsigned long)self.selectedTea.temperature];
    self.boilProgressView.progress = 0.f;

    // Infusion
    self.serveButton.alpha = 0.f;
    self.infusionDelayMinLabel.text = @"0 s";
    self.infusionDelayMaxLabel.text = [NSString stringWithFormat:@"%lu s", (unsigned long)self.selectedTea.duration];
    self.infusionCurrentLabel.text = @"";
    self.infusionProgressView.progress = 0.f;

    [[SocketService sharedInstance].socket emit:@"setBoil"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            for (self.boilProgress = 0; self.boilProgress < self.selectedTea.temperature; self.boilProgress++) {
                NSLog(@"%lu / %lu", (unsigned long)self.boilProgress, (unsigned long)self.selectedTea.temperature);
                [NSThread sleepForTimeInterval:kDurationSleep];
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    NSLog(@"progress: %f", (float)self.boilProgress / (float)self.selectedTea.temperature);
                    self.boilProgressView.progress = (float)self.boilProgress / (float)self.selectedTea.temperature;
                });
            }

            dispatch_async(dispatch_get_main_queue(), ^(void){
                [UIView animateWithDuration:0.7 animations:^{
                    self.infusionButton.alpha = 1.0;
                }];
            });
        });
    });
}

#pragma mark - Actions

- (IBAction)startInfusion:(id)sender {
    self.boilView.alpha = 0.f;
    self.infusionView.hidden = NO;

    [[SocketService sharedInstance].socket emit:@"infuse"];

    [UIView transitionWithView:self.containerView
                      duration:0.7
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^{
                        self.boilView.alpha = 0.0;
                        self.infusionView.alpha = 1.0;
                    }
                    completion:^(BOOL finished) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                                for (self.infusionProgress = 0; self.infusionProgress < self.selectedTea.duration; self.self.infusionProgress++) {
                                    NSLog(@"%lu / %lu", (unsigned long)self.infusionProgress, (unsigned long)self.selectedTea.duration);
                                    [NSThread sleepForTimeInterval:kDurationSleep];
                                    dispatch_async(dispatch_get_main_queue(), ^(void){
                                        NSLog(@"progress: %f", (float)self.infusionProgress / (float)self.selectedTea.duration);
                                        self.infusionProgressView.progress = (float)self.infusionProgress / (float)self.selectedTea.duration;
                                    });
                                }

                                dispatch_async(dispatch_get_main_queue(), ^(void){
                                    [UIView animateWithDuration:0.7 animations:^{
                                        self.serveButton.alpha = 1.0;
                                    }];
                                });
                            });
                        });
                    }];
}

- (IBAction)serve:(id)sender {
    [self performSegueWithIdentifier:@"cupSegue" sender:nil];
}

@end

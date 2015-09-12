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

@interface CupViewController ()

@property (nonatomic, weak) IBOutlet UIProgressView *progressView;

@end

@implementation CupViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    __block CGFloat maxTemp = 0.1;
    @weakify(self);
    [[SocketService sharedInstance].socket on:@"celsius" callback:^(NSArray *args) {
        @strongify(self);
        NSNumber *tempNumber = [args firstObject];
        if (tempNumber != nil) {
            CGFloat temp = [tempNumber floatValue];
            if (temp > maxTemp) {
                maxTemp = temp;
            }
            self.progressView.progress = temp / maxTemp;
        }
        NSLog(@"args: %@", args);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

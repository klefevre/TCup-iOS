//
//  CupViewController.m
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import "CupViewController.h"

#import <SIOSocket/SIOSocket.h>

@interface CupViewController ()

@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) SIOSocket *socket;

@end

@implementation CupViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [SIOSocket socketWithHost: @"http://192.168.100.183:1337" response:^(SIOSocket *socket) {
        self.socket = socket;

        [socket on:@"connected" callback:^(NSArray *args) {
            NSLog(@"args: %@", args);
        }];

        __block CGFloat maxTemp = 0;
        [socket on:@"celsius" callback:^(NSArray *args) {
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
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

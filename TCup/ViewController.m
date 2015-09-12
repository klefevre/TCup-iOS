//
//  ViewController.m
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

#import "ViewController.h"

#import "BTDiscovery.h"

@interface ViewController () <BTDiscoveryDelegate>

@property (nonatomic, strong) BTDiscovery *btDiscovery;

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.btDiscovery = [[BTDiscovery alloc] initWithDelegate:self];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Not connected"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)connect:(id)sender {
//    [self.btDiscovery startScanning];
}

#pragma mark - BTDiscoveryDelegate

- (void)peripheralConnecting {
    self.navigationItem.rightBarButtonItem.title = @"Connecting";
}

- (void)peripheralDidConnect {
    self.navigationItem.rightBarButtonItem.title = @"Connected";
}

- (void)peripheralDidDisconnect {
    self.navigationItem.rightBarButtonItem.title = @"Not connected";
}

@end

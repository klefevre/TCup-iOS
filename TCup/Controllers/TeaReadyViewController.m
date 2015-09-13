//
//  TeaReadyViewController.m
//  TCup
//
//  Created by Kevin Lefevre on 13/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import "TeaReadyViewController.h"

@interface TeaReadyViewController ()

@end

@implementation TeaReadyViewController

#pragma mark - View lifecylce

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)doAnotherTea:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [(UINavigationController *)self.presentingViewController popToRootViewControllerAnimated:NO];
}

@end

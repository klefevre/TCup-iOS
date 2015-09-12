//
//  CupViewController.m
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import "CupViewController.h"

#import <SocketRocket/SRWebSocket.h>

@interface CupViewController () <SRWebSocketDelegate>

@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) SRWebSocket *webSocket;

@end

@implementation CupViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURLRequest *url = [NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://localhost:9000/chat"]];
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:url];
    self.webSocket.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"message: %@", message);
}

@end

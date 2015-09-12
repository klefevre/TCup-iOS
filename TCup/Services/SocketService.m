//
//  SocketService.m
//  TCup
//
//  Created by Kevin Lefevre on 13/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import <ReactiveCocoa/RACEXTScope.h>
#import "SocketService.h"

@interface SocketService ()

@property (nonatomic, strong) SIOSocket *socket;

@end

@implementation SocketService

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Public

- (void)connect:(NSString *)url {
    @weakify(self);
    [SIOSocket socketWithHost:url response:^(SIOSocket *socket) {
        @strongify(self);
        self.socket = socket;

        socket.onConnect = ^{
            NSLog(@"on connected");
        };

        socket.onDisconnect = ^{
            NSLog(@"on disconnect");
            self.socket = nil;
        };

        socket.onError = ^(NSDictionary *errorInfo) {
            NSLog(@"on error: %@", errorInfo);
        };

        [socket on:@"connected" callback:^(NSArray *args) {
            NSLog(@"args: %@", args);
        }];
    }];
}


@end

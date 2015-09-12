//
//  SocketService.h
//  TCup
//
//  Created by Kevin Lefevre on 13/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SIOSocket/SIOSocket.h>

@interface SocketService : NSObject

@property (nonatomic, readonly, strong) SIOSocket *socket;

+ (instancetype)sharedInstance;
- (void)connect:(NSString *)url;

@end

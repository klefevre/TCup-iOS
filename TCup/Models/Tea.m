//
//  Tea.m
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import "Tea.h"

@implementation Tea

#pragma mark - Initialization

+ (instancetype)teaWithImageName:(NSString *)imageName withDuration:(NSUInteger)duration withTemperature:(NSUInteger)temperature {
    return [[self alloc] initWithImageName:imageName withDuration:duration withTemperature:temperature];
}

- (instancetype)initWithImageName:(NSString *)imageName withDuration:(NSUInteger)duration withTemperature:(NSUInteger)temperature {
    if ((self = [super init])) {
        _imageName = imageName;
        _duration = duration;
        _temperature = temperature;
    }
    return self;
}

@end

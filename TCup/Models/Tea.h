//
//  Tea.h
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tea : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) NSUInteger temperature;
@property (nonatomic, assign) NSUInteger duration;

+ (instancetype)teaWithImageName:(NSString *)imageName withDuration:(NSUInteger)duration withTemperature:(NSUInteger)temperature;
- (instancetype)initWithImageName:(NSString *)imageName withDuration:(NSUInteger)duration withTemperature:(NSUInteger)temperature;

@end

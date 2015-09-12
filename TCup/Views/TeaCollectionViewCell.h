//
//  TeaCollectionViewCell.h
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tea;

@interface TeaCollectionViewCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;
- (void)setupWithTea:(Tea *)tea;

@end

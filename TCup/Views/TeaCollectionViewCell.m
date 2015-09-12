//
//  TeaCollectionViewCell.m
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import "TeaCollectionViewCell.h"
#import "Tea.h"

static NSString *const kReuseIdentifier = @"TeaCollectionViewCell";

@interface TeaCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *durationLabel;

@end

@implementation TeaCollectionViewCell

+ (NSString *)reuseIdentifier {
    return kReuseIdentifier;
}

- (void)setupWithTea:(Tea *)tea {
    self.imageView.image = [UIImage imageNamed:tea.imageName];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%lu °C", (unsigned long)tea.temperature];
    self.durationLabel.text = [NSString stringWithFormat:@"%lu mm", (unsigned long)tea.duration];
}

@end

//
//  TeaCollectionViewController.m
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import "TeaCollectionViewController.h"
#import "Tea.h"
#import "TeaCollectionViewCell.h"

#import "KettleViewController.h"

@interface TeaCollectionViewController ()

@property (nonatomic, strong) NSArray *teas;

@end

@implementation TeaCollectionViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.teas = @[[Tea teaWithImageName:@"01" withDuration:100 withTemperature:150],
                  [Tea teaWithImageName:@"02" withDuration:140 withTemperature:80],
                  [Tea teaWithImageName:@"03" withDuration:60 withTemperature:110],
                  [Tea teaWithImageName:@"04" withDuration:90 withTemperature:120],
                  [Tea teaWithImageName:@"05" withDuration:160 withTemperature:100]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    KettleViewController *vc = (id)segue.destinationViewController;
    vc.selectedTea = self.teas[[self.collectionView indexPathForCell:sender].row];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.teas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TeaCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell setupWithTea:self.teas[indexPath.row]];
    return cell;
}

@end

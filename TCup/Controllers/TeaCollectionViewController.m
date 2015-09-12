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

@interface TeaCollectionViewController ()

@property (nonatomic, strong) NSArray *teas;

@end

@implementation TeaCollectionViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.teas = @[[Tea teaWithImageName:@"01" withDuration:100 withTemperature:100],
                  [Tea teaWithImageName:@"02" withDuration:100 withTemperature:100],
                  [Tea teaWithImageName:@"03" withDuration:100 withTemperature:100],
                  [Tea teaWithImageName:@"04" withDuration:100 withTemperature:100],
                  [Tea teaWithImageName:@"05" withDuration:100 withTemperature:100]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

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

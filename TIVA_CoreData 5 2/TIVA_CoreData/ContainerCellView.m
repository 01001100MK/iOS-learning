//
//  ContainerCellView.m
//  TIVA_CoreData
//
//  Created by Nay on 10/17/16.
//  Copyright © 2016 Nay. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ContainerCellView.h"
#import "CollectionViewCell.h"

@interface ContainerCellView () <UICollectionViewDataSource, UICollectionViewDelegate>

    @property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ContainerCellView

- (void)awakeFromNib
{
    
    [super awakeFromNib];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(100, 150);
    flowLayout.minimumInteritemSpacing = 10;
    [self.collectionView setCollectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    // Register the colleciton cell
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];

    // Generate random number between 0-4
    int index = arc4random() % 5;
    NSString *image = [NSString stringWithFormat:@"%d.jpg", index];
    cell.LatestPoster.image = [UIImage imageNamed:image];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected: %@", indexPath);
}


@end

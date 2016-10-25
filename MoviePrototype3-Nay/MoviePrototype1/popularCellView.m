//
//  popularCellView.m
//  MoviePrototype1
//
//  Created by TIVA on 10/19/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "popularCellView.h"
#import "popularCollectionViewCell.h"

@interface popularCellView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation popularCellView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(100, 150);
    flowLayout.minimumInteritemSpacing = 10;
    [self.collectionView setCollectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    [self.collectionView registerNib:[UINib nibWithNibName:@"popularCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"popularCollectionViewCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    popularCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"popularCollectionViewCell" forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"%d.jpg", 2];
    cell.posterImage.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected: %@", indexPath);
}

@end

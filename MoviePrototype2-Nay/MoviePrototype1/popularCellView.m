//
//  popularCellView.m
//  MoviePrototype1
//
//  Created by TIVA on 10/19/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "popularCellView.h"
#import "popularCollectionViewCell.h"
#import "ApiCalls.h"


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

    _popularArray = [[ApiCalls GetPopularMovies] objectForKey:@"results"];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        _popularArray = [[ApiCalls GetPopularMovies] objectForKey:@"results"];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
//    });
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_popularArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    popularCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"popularCollectionViewCell" forIndexPath:indexPath];
    
    NSString *posterPath = [NSString stringWithString:[[_popularArray objectAtIndex:indexPath.row] valueForKey:@"poster_path"]];
//    NSData *imageData = [ApiCalls GetImageDataForMovieUrl:posterPath];
//    UIImage *posterImage = [UIImage imageWithData:imageData];
//    cell.posterImage.image = posterImage;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [ApiCalls GetImageDataForMovieUrl:posterPath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *posterImage = [UIImage imageWithData:imageData];
            cell.posterImage.image = posterImage;
        });
    });
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected: %@", indexPath);
}

@end

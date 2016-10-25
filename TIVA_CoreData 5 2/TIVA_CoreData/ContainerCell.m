//
//  ContainerCell.m
//  TIVA_CoreData
//
//  Created by Nay on 10/18/16.
//  Copyright © 2016 Nay. All rights reserved.
//

#import "ContainerCell.h"
#import "ContainerCellView.h"

@interface ContainerCell()
    @property (strong, nonatomic) ContainerCellView *collectionView;
@end

@implementation ContainerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _collectionView = [[NSBundle mainBundle] loadNibNamed:@"ContainerCellView"
                                                        owner:self
                                                      options:nil][0];
        _collectionView.frame = self.bounds;
        [self.contentView addSubview:_collectionView];
    }
    return self;
}


@end

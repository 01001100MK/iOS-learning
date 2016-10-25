//
//  popularTableViewCell.m
//  MoviePrototype1
//
//  Created by TIVA on 10/19/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "popularTableViewCell.h"

// import Collection cell view
#import "popularCellView.h"

@interface popularTableViewCell()

@property (strong, nonatomic) popularCellView *popularCellView;

@end


@implementation popularTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.popularCellView = [[NSBundle mainBundle] loadNibNamed:@"popularCellView"
                                                        owner:self
                                                      options:nil][0];
        self.popularCellView.frame = self.bounds;
        [self.contentView addSubview:self.popularCellView];
    }
    return self;
}

@end

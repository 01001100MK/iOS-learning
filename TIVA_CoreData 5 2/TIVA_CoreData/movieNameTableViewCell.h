//
//  movieNameTableViewCell.h
//  Tiva Test 3
//
//  Created by TIVA on 10/6/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface movieNameTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *overviewTextView;
@property (weak, nonatomic) IBOutlet UIImageView *posterimage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

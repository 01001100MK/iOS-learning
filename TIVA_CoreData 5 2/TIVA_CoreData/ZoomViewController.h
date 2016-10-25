//
//  ZoomViewController.h
//  TIVA_CoreData
//
//  Created by Nay on 10/18/16.
//  Copyright © 2016 Nay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (strong, nonatomic) UIImage *posterImg;

@property (strong, nonatomic) NSMutableArray *movieListZoom;
@property (strong, nonatomic) NSIndexPath *path;

@end

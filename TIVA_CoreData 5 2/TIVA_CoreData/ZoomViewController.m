//
//  ZoomViewController.m
//  TIVA_CoreData
//
//  Created by Nay on 10/18/16.
//  Copyright © 2016 Nay. All rights reserved.
//

#import "ZoomViewController.h"

@interface ZoomViewController ()

@property (nonatomic, assign) int currentIndex;

@end

@implementation ZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentIndex = (int)_path.row;
    
    NSData *imgData = [[_movieListZoom objectAtIndex:_currentIndex] valueForKey:@"poster"];
    _posterImg = [UIImage imageWithData:imgData];
    self.posterImage.image = _posterImg;
    
    UISwipeGestureRecognizer *swipeGestureUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeView:)];
    [swipeGestureUp setNumberOfTouchesRequired:1];
    swipeGestureUp.direction = UISwipeGestureRecognizerDirectionUp;
    self.posterImage.userInteractionEnabled = YES;
    [self.posterImage addGestureRecognizer:swipeGestureUp];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveLeft:)];
    [swipeGestureLeft setNumberOfTouchesRequired:1];
    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.posterImage addGestureRecognizer:swipeGestureLeft];
    
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveRight:)];
    [swipeGestureRight setNumberOfTouchesRequired:1];
    swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.posterImage addGestureRecognizer:swipeGestureRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)closeView:(UISwipeGestureRecognizer *)recognizer {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)moveLeft:(UISwipeGestureRecognizer *)recognizer {
    if (_currentIndex < [_movieListZoom count] - 1) {
        _currentIndex++;
        
        NSData *imgData = [[_movieListZoom objectAtIndex:_currentIndex] valueForKey:@"poster"];
        _posterImg = [UIImage imageWithData:imgData];
        self.posterImage.image = _posterImg;
    }
}

-(void)moveRight:(UISwipeGestureRecognizer *)recognizer {
    if (_currentIndex > 0) {
        _currentIndex--;
        
        NSData *imgData = [[_movieListZoom objectAtIndex:_currentIndex] valueForKey:@"poster"];
        _posterImg = [UIImage imageWithData:imgData];
        self.posterImage.image = _posterImg;
    }
}
@end

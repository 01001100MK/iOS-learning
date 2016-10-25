//
//  editViewController.m
//  TIVA_CoreData
//
//  Created by Nay on 10/13/16.
//  Copyright © 2016 Nay. All rights reserved.
//

#import "editViewController.h"

@interface editViewController ()

@end

@implementation editViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.overviewTextView setContentOffset:CGPointZero animated:NO];

    self.titleText.delegate = self;
    self.overviewTextView.delegate = self;
    
    self.titleText.text = [_detailMovie valueForKey:@"original_title"];
    self.overviewTextView.text = [_detailMovie valueForKey:@"overview"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.titleText){
        [self.overviewTextView becomeFirstResponder];
    }
    
    return YES;
    
    
//    NSInteger nextTag = textField.tag + 1;
//    // Try to find next responder
//    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
//    
//    if (nextResponder) {
//        // Found next responder, so set it.
//        [nextResponder becomeFirstResponder];
//    } else {
//        // Not found, so remove keyboard.
//        [textField resignFirstResponder];
//    }
//    return NO; // We do not want UITextField to insert line-breaks.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

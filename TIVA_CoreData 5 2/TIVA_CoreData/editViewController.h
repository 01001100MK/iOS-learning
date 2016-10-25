//
//  editViewController.h
//  TIVA_CoreData
//
//  Created by Nay on 10/13/16.
//  Copyright © 2016 Nay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface editViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate>

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextView *overviewTextView;
@property (strong, nonatomic) NSMutableArray *detailMovie;


@end

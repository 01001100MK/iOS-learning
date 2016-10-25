//
//  detailTableViewController.h
//  Tiva Test 3
//
//  Created by TIVA on 10/6/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailTableViewCell.h"
#import "posterTableViewCell.h"

@interface detailTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableDictionary *movieInfo;
@property (strong, nonatomic) NSString *movieID;

@end

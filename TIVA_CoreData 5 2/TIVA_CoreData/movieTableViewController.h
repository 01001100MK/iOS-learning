//
//  movieTableViewController.h
//  Tiva Test 3
//
//  Created by TIVA on 10/6/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "movieNameTableViewCell.h"

@interface movieTableViewController : UITableViewController <UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UISearchController *searchController;

- (IBAction)refreshButton:(UIBarButtonItem *)sender;

@end

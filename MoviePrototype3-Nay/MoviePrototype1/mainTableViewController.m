//
//  mainTableViewController.m
//  MoviePrototype1
//
//  Created by TIVA on 10/19/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "mainTableViewController.h"

// Collection Views
#import "todayTableViewCell.h"
#import "popularTableViewCell.h"
#import "m4uTableViewCell.h"

@interface mainTableViewController ()

@end

@implementation mainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"M4U";
    
    // Register custom cells
    [self.tableView registerClass:[todayTableViewCell
                                   class] forCellReuseIdentifier:@"todayCell"];

    [self.tableView registerClass:[popularTableViewCell
                                   class] forCellReuseIdentifier:@"popularCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2){
        return 1;
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

// Title for Header section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        return @"Today Watch List";
    }
    else if (section == 1){
        return @"Popular Movies";
    }
    else{
        return @"M4U List";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = tableView.frame;
    
    // Button
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-90, 10, 100, 30)];
    [addButton addTarget:self action:@selector(SeeAll:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"See All >" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    
    // Add tag to identify section in @selector method
    addButton.tag = section;
    
    // Section Header
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 30)];
    title.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    if (section == 0){
        title.text = @"Today Watch List";
    }
    else if (section == 1){
        title.text = @"Popular Movies";
    }
    else{
        title.text = @"M4U";
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];

    [headerView addSubview:title];
    [headerView addSubview:addButton];

    return headerView;
}


- (void)SeeAll:(UIButton *)sender
{
    NSLog(@"%@ for %ld", @"Show all for section: ", (long)sender.tag);
}


// Formatting for Header section
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
//    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    header.textLabel.textColor = [UIColor darkGrayColor];
//    header.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//    CGRect headerFrame = header.frame;
//    header.textLabel.frame = headerFrame;
//    header.textLabel.textAlignment = NSTextAlignmentLeft;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        todayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todayCell" forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 1) {
        popularTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popularCell" forIndexPath:indexPath];
        return cell;
    }
    else {
        m4uTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"m4uCell" forIndexPath:indexPath];
        return cell;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

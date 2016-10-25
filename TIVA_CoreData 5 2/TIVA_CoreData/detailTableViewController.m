//
//  detailTableViewController.m
//  Tiva Test 3
//
//  Created by TIVA on 10/6/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "detailTableViewController.h"
#import "APICalls.h"

@interface detailTableViewController ()

@property (strong, nonatomic) NSArray *movieData;

@end

@implementation detailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disable row selection
    self.tableView.allowsSelection = NO;
    
    
    //======= Multi-tasking using GCD to make UI response faster ========
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Run code with slow response (*** NO UI STATEMENTS ***)
        // Call API
        //_movieInfo = [APICalls GetDetailForMovieID:_movieID];
        
        // Fill movie info
        NSString *title = [_movieInfo valueForKey:@"original_title"];
        NSString *overview = [_movieInfo valueForKey:@"overview"];
        NSString *release_date = [_movieInfo valueForKey:@"release_date"];
        NSString *vote_average = [NSString stringWithFormat:@"%@", [_movieInfo valueForKey:@"vote_average"]];
        NSData *poster_image = [_movieInfo valueForKey:@"poster"];
        
        _movieData = [[NSArray alloc] init];
        _movieData = [NSArray arrayWithObjects:poster_image, title, overview, release_date, vote_average, nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Run UI-related statements
            // Refresh Table (UI)
            [self.tableView reloadData];
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        // Poster Image section
        return 1;
    }
    else{
        // Less 1 to skip poster image field
        return [_movieData count]-1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return 400;
    }
    else{
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    if (indexPath.section == 0){
        // First Cell
        posterTableViewCell *posterCell = [tableView dequeueReusableCellWithIdentifier:@"posterViewCell" forIndexPath:indexPath];
        posterCell.posterImage.image = [UIImage imageWithData:[_movieData objectAtIndex:indexPath.row]];
        return posterCell;
    }
    else{
        // Second Cell
        detailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"detailViewCell" forIndexPath:indexPath];
        // Add 1 to skip poster image field
        detailCell.movieInfoLabel.text = [_movieData objectAtIndex:(indexPath.row + 1)];
        return detailCell;
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

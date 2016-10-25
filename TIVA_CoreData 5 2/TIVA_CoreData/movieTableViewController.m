//
//  movieTableViewController.m
//  Tiva Test 3
//
//  Created by TIVA on 10/6/16.
//  Copyright © 2016 TIVA. All rights reserved.
//
#import "movieTableViewController.h"
#import "detailTableViewController.h"
#import "editViewController.h"
#import "ZoomViewController.h"
#import "APICalls.h"

// Collection View
#import "ContainerCell.h"


@interface movieTableViewController ()
    @property (strong, nonatomic) NSMutableArray *movieImg;
    @property (strong, nonatomic) NSDictionary *locationInfo;
    @property (strong, nonatomic) NSDictionary *movieRecommendations;
    @property (strong, nonatomic) NSArray *movieList;
    @property (strong, nonatomic) NSMutableArray *movieListFiltered;
    @property (strong, nonatomic) NSMutableArray *movieImages;

    @property (strong, nonatomic) NSArray *colorArray;
@end


@implementation movieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Format Table View
    self.title = @"TIVA Movie";

    // Collection View
    [self.tableView registerClass:[ContainerCell class] forCellReuseIdentifier:@"ContainerCell"];
    
    // Message when there is No data
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    messageLabel.text = @"No data is currently available!\n Please pull down to refresh.";
    messageLabel.textColor = [UIColor lightGrayColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    [messageLabel sizeToFit];
    self.tableView.backgroundView = messageLabel;
    
    // Initialize the refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor darkGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    NSString *title = @"Pull down to refresh";
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    self.refreshControl.attributedTitle = attributedTitle;
    [self.refreshControl addTarget:self action:@selector(refreshMovies) forControlEvents:UIControlEventValueChanged];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Initialize Search Bar
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.scopeButtonTitles = @[];
    self.searchController.searchBar.delegate = self;
    
    // Format Search Bar
    self.searchController.searchBar.barStyle = UIBarStyleBlack;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchController.searchBar.translucent = YES;
    self.searchController.searchBar.keyboardType = UIKeyboardAppearanceDefault;
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // Add Search bar to table view controller
    self.tableView.tableHeaderView = self.searchController.searchBar;

    // Hide the search bar until user scrolls up
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + _searchController.searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;

    //*** The problem with blank space when SearchBar active is due to
    //   'Translucent-OFF' in NavigationBar of NavigationController. ***

    // Hide hair line below Navigation Bar
    [self.navigationController.navigationBar setBackgroundColor:[UIColor darkGrayColor]];
    
    // Fetch the movies from database
    _movieList = [[NSArray alloc] initWithArray:[self GetMovies]];
    
    // Download only if local database is empty
    if ([_movieList count] == 0){
        [self refreshMovies];
    }
    else{
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshMovies
{
    //======= Multi-tasking using GCD to make UI response faster ========
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Run code with slow response (*** NO UI STATEMENTS ***)
        // Call API
        _movieList = [[NSArray alloc] init];
        _movieList = [[APICalls GetRecommendationsForMovieID:@"550"] objectForKey:@"results"];
        
        // Check for empty data or No Internet connection
        NSString *imageURL = @"";
        _movieImages = [[NSMutableArray alloc] init];
        for (int i=0; i < [_movieList count]; i++){
            imageURL = [[_movieList objectAtIndex:i] valueForKey:@"poster_path"];
            [_movieImages addObject:[APICalls GetImageForRecommendedMovie:imageURL]];
        }
        
        // Save the Movies in Database
        [self saveMoviesDBwithData:_movieList withImages:_movieImages];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Run UI-related statements
            // Fetch the movies from database
            _movieList = [[NSArray alloc] initWithArray:[self GetMovies]];
            
            // Check for empty data or No Internet connection
            if ([_movieList count] > 0){
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                [self.tableView reloadData];
            }
            else{
                [self MyAlertWithTitle:@"Sorry!" andMessage:@"Empty Data. Please check Internet connection."];
            }
            
            // Stop and close refresh control
            [self.refreshControl endRefreshing];
        });
    });
}
    
#pragma mark -
#pragma ======= Search Controller ===========

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchStr = searchController.searchBar.text;
    _movieListFiltered = [[NSMutableArray alloc] init];
    
    if ([searchStr length] > 0){
        // Start Filter
        // *--select * from tbl where column1 like '%a%'--*
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.original_title contains[c] %@", searchStr];
        
        _movieListFiltered = [NSMutableArray arrayWithArray:[_movieList filteredArrayUsingPredicate:predicate]];
    }
    else{
        // Show all for empty search box
        _movieListFiltered = [_movieList mutableCopy];
    }
    
    // Refresh Table View Controller
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    [self MyAlertWithTitle:@"Search" andMessage:searchBar.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark ========== Table view data source =========

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        return 1;
    }
    else{
        if (_searchController.active){
            return [_movieListFiltered count];
        }
        else{
            return [_movieList count];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return 170;
    }
    else{
        return 225;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        ContainerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContainerCell"
                                                              forIndexPath:indexPath];
        return cell;
    }
    else{
        NSManagedObject *movie;
        movieNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieNameCell"
                                                                       forIndexPath:indexPath];

        if (_searchController.active){
            movie = [_movieListFiltered objectAtIndex:indexPath.row];
        }
        else{
            movie = [_movieList objectAtIndex:indexPath.row];
        }
        
        cell.posterimage.image = [UIImage imageWithData:[movie valueForKey:@"poster"]];
        cell.titleLabel.text = [movie valueForKey:@"original_title"];
        cell.releaseLabel.text = [movie valueForKey:@"release_date"];
        cell.ratingLabel.text = [NSString stringWithFormat:@"\u2605 %@", [movie valueForKey:@"vote_average"]];
        cell.overviewTextView.text = [movie valueForKey:@"overview"];
        
        // Remove row selection color
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Add Tap Gesture to Image View
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        tapGesture1.numberOfTapsRequired = 1;
        tapGesture1.view.tag = indexPath.row;
        cell.posterimage.userInteractionEnabled = YES;
        cell.posterimage.tag = indexPath.row;
        [cell.posterimage addGestureRecognizer:tapGesture1];
        
        return cell;
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)sender
{
    // handle Tap...
    UIImageView *cell = (UIImageView *)sender.view;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cell.tag inSection:1];
    
    [self performSegueWithIdentifier:@"toZoomVC" sender:indexPath];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0){
        return NO;
    }
    else {
        return YES;
    }
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self performSegueWithIdentifier:@"toEditVC" sender:indexPath];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"toDetailVC"]) {
        // To View Movie details
        detailTableViewController *Vctrlr = (detailTableViewController *)segue.destinationViewController;
        int row = (int) [self.tableView indexPathForCell:sender].row;
        
        if (_searchController.active){
            Vctrlr.movieID = [[_movieListFiltered objectAtIndex:row] valueForKey:@"id"];
            Vctrlr.movieInfo = [_movieListFiltered objectAtIndex:row];
        }
        else{
            Vctrlr.movieID = [[_movieList objectAtIndex:row] valueForKey:@"id"];
            Vctrlr.movieInfo = [_movieList objectAtIndex:row];
        }
    
    }
    else if ([segue.identifier isEqualToString:@"toEditVC"]) {
        // Edit Movie Info
        UINavigationController *navigationController = segue.destinationViewController;
        editViewController *Vctrlr2 = (editViewController *)navigationController.topViewController;
        NSIndexPath *path = sender;
        int row = (int) path.row;
        
        if (_searchController.active){
            Vctrlr2.title = [[_movieListFiltered objectAtIndex:row] valueForKey:@"original_title"];
            Vctrlr2.detailMovie = [_movieListFiltered objectAtIndex:row];
        }
        else{
            Vctrlr2.title = [[_movieList objectAtIndex:row] valueForKey:@"original_title"];
            Vctrlr2.detailMovie = [_movieList objectAtIndex:row];
        }
    }
    else if ([segue.identifier isEqualToString:@"toZoomVC"]) {
        // To View Movie details
        ZoomViewController *Vctrlr = (ZoomViewController *)segue.destinationViewController;
        
        if (_searchController.active){
            Vctrlr.movieListZoom = _movieListFiltered;
            Vctrlr.path = sender;
        }
        else{            
            Vctrlr.movieListZoom = [NSMutableArray arrayWithArray:_movieList];
            Vctrlr.path = sender;
        }
        
    }
}

#pragma mark -
#pragma mark ----------- Database (Core Data) ---------------

- (void)saveMoviesDBwithData:(NSArray *)data withImages:(NSMutableArray *)movieImages
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Clean Local database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Movie"];
    NSMutableArray *fetchedObjects;
    NSError *error = nil;
    
    // Fetch data from persistent data store
    fetchedObjects = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];

    // Clean the persistent store before save.
    for (NSManagedObject *object in fetchedObjects){
        [context deleteObject:object];
    }
    if (![context save:&error]) {
        NSLog(@"ERROR: %@", error.description);
    }

    // Convert string to date object
    NSDate *RelDate;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    // For-Loop
    for (int i=0; i < [data count]; i++){
        RelDate = [dateFormat dateFromString:[[data objectAtIndex:i] objectForKey:@"release_date"]];
        
        // Create and Insert a new managed object
        NSManagedObject *newRec = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:context];
        [newRec setValue:[[data objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
        [newRec setValue:[[data objectAtIndex:i] objectForKey:@"original_title"] forKey:@"original_title"];
        [newRec setValue:[[data objectAtIndex:i] objectForKey:@"overview"] forKey:@"overview"];
        [newRec setValue:[[data objectAtIndex:i] objectForKey:@"release_date"] forKey:@"release_date"];
        [newRec setValue:[[data objectAtIndex:i] objectForKey:@"vote_average"] forKey:@"vote_average"];
        [newRec setValue:[movieImages objectAtIndex:i] forKey:@"poster"];
    }

    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (NSArray *)GetMovies
{
    // Fetch the movies from database
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Movie"];
    NSMutableArray *data = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];

    // Sort Movie List
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"original_title"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [data sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}


#pragma mark -

- (void)MyAlertWithTitle:(NSString *)title andMessage:(NSString *)message
{
    UIAlertController *alertCtrlr = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    [alertCtrlr addAction:[UIAlertAction actionWithTitle:@"Ok"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action) {
         [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    // Show alert view
    [self presentViewController:alertCtrlr animated:YES completion:nil];
    
}

- (IBAction)refreshButton:(UIBarButtonItem *)sender
{
    [self refreshMovies];
}
@end

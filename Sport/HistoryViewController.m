//
//  HistoryViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/23/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "HistoryViewController.h"
#import "DataManager.h"
#import "HistoryCell.h"
#import "Workout.h"
#import "Rep.h"
#import "Util.h"
#import "DetailsViewController.h"

@interface HistoryViewController () {
    NSMutableArray *_workoutList;
    NSMutableDictionary *_workoutDictionary;
    }

@end

@implementation HistoryViewController
@synthesize pageIndex, titleText;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_workoutList) {
        _workoutList = [[NSMutableArray alloc] init];
        _workoutDictionary = [[NSMutableDictionary alloc] init];
    }
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ergs_bw.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    
    [self.tableView setBackgroundView:tempImageView];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    _workoutList = [[DataManager sharedInstance] getWorkoutArray];
//    _workoutList = [[DataManager sharedInstance] fetchWorkouts];
    _workoutDictionary = [self sortWorkoutsByDate];
    [self.tableView reloadData];
    [self.navigationController.navigationBar.topItem setTitle:titleText];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"darkGray"] forBarMetrics:UIBarMetricsDefault];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_workoutDictionary allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *keys = [_workoutDictionary allKeys];
    NSString *key = [keys objectAtIndex:section];
    NSMutableArray *array = [_workoutDictionary valueForKey:key];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *keys = [self makeHeadersFromDictionary:_workoutDictionary];
    NSString *key = [keys objectAtIndex:indexPath.section];
    NSMutableArray *array = [_workoutDictionary valueForKey:key];
    
    Workout *w = [array objectAtIndex:indexPath.row];
    
    int totalDist = 0.0;
    double totalTime = 0.0;
    NSMutableArray *repsArray = [[NSMutableArray alloc] init];
    for (id r in w.rep) {
        Rep *rep = (Rep *)r;
        [repsArray addObject:rep];
        totalDist += rep.totalDistance.integerValue;
        totalTime += rep.totalTime.doubleValue;
    }
    
    [cell.labelName setText:w.name];
    [cell.labelDate setText:[Util stringFromDateWithDayOfWeek:w.date]];
    
    [cell.labelTotalMeters setText:[[NSString stringWithFormat:@"%d",totalDist] stringByAppendingString:@" m"]];
    [cell.labelTotalTime setText:[NSString stringWithFormat:@"%@", [Util getSplitForSeconds:[NSNumber numberWithDouble:totalTime]]]];
    [cell.labelAverageSplit setText:[Util getSplitStringFromDistance:[NSNumber numberWithInt:totalDist] andTime:[NSNumber numberWithDouble:totalTime]] ];
//    [cell setBackgroundColor:[UIColor clearColor]];
    
    // Configure the cell...
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 25.0)];
    [customView setBackgroundColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0]];
    
    
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1.0];
	headerLabel.frame = CGRectMake(10.0, 4.0, 300.0, 16.0);
    headerLabel.font = [UIFont fontWithName:@"" size:14];
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    
    NSMutableArray *headers = [self makeHeadersFromDictionary:_workoutDictionary];
    headerLabel.text = [headers objectAtIndex:section];
	[customView addSubview:headerLabel];
    
    
//    UIImageView *sepLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seperator_line"]];
//    sepLine.frame = CGRectMake(0, 0, customView.frame.size.width, 1);
//    [customView addSubview:sepLine];
    
    
	return customView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

-(NSMutableArray *) makeHeadersFromDictionary:(NSMutableDictionary *)dict {
    NSMutableArray *keys = [[dict allKeys] mutableCopy];
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for (NSString *key in keys) {
        [dates addObject:[Util dateFromStringMMYY:key]];
    }
    [dates sortUsingSelector:@selector(compare:)];
    NSMutableArray *finalDates = [[NSMutableArray alloc] init];
    for (long i = dates.count-1; i >= 0; i--) {
        [finalDates addObject:[Util stringFromDateMMYY:[dates objectAtIndex:i]]];
    }
    return finalDates;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailsPush"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        NSArray *keys = [self makeHeadersFromDictionary:_workoutDictionary];
        NSString *key = [keys objectAtIndex:path.section];
        NSMutableArray *array = [_workoutDictionary valueForKey:key];
        
        Workout *w = [array objectAtIndex:path.row];
        
        DetailsViewController *controller = (DetailsViewController*) segue.destinationViewController;
        [controller setWorkout:w];
    }
}




- (NSMutableDictionary *)sortWorkoutsByDate {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (Workout *w in _workoutList) {
        NSString *dateString = [Util stringFromDateMMYY:w.date];
        
        BOOL found = NO;
        for (NSString *str in [dict allKeys]) {
            if ([str isEqualToString:dateString]) {
                found = YES;
            }
        }
        if (!found) {
            [dict setValue:[[NSMutableArray alloc] init] forKey:dateString];
        }
    }
    
    for (Workout *w in _workoutList) {
        NSString *dateString = [Util stringFromDateMMYY:w.date];
        [[dict objectForKey:dateString] addObject:w];
    }
    
    for (NSString *key in dict.allKeys) {
        NSMutableArray *array = [dict valueForKey:key];
        [array sortUsingSelector:@selector(compareByDate:)];
    }
    
    return dict;
}


@end

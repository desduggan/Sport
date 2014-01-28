//
//  DetailsViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/26/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "DetailsViewController.h"
#import "Workout.h"
#import "Rep.h"
#import "Util.h"
#import "AddWorkoutCell.h"

@interface DetailsViewController () {
    __weak IBOutlet UIView *_topView;
    NSMutableArray *_repsArray;
    
    __weak IBOutlet UITableView *_tableView;
    
    
    __weak IBOutlet UILabel *_labelName;
    
    __weak IBOutlet UILabel *_labelDate;
    __weak IBOutlet UILabel *_labelLocation;
    __weak IBOutlet UILabel *_labelDistance;
    __weak IBOutlet UILabel *_labelTotalTime;
    __weak IBOutlet UILabel *_labelSplit;
    
}

@end

@implementation DetailsViewController
@synthesize workout;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_topView.layer setShadowOffset:CGSizeMake(1, 1)];
    [_topView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_topView.layer setShadowRadius:4.0];
    [_topView.layer setShadowOpacity:.8f];
    [_topView.layer setShadowPath:[[UIBezierPath bezierPathWithRect:_topView.layer.bounds] CGPath]];
    
    if (!_repsArray) {
        _repsArray = [[NSMutableArray alloc] init];
    }
    
    int totalDist = 0.0;
    double totalTime = 0.0;
    for (id r in workout.rep) {
        Rep *rep = (Rep *)r;
        [_repsArray addObject:rep];
        totalDist += rep.totalDistance.integerValue;
        totalTime += rep.totalTime.doubleValue;
    }
    
    // Init the page with workout data
    [_labelName setText:workout.name];
    [_labelDate setText:[Util stringFromDate:workout.date]];
    [_labelLocation setText:workout.location];
    [_labelDistance setText:[[NSString stringWithFormat:@"%d",totalDist] stringByAppendingString:@" meters"]];
    [_labelTotalTime setText:[NSString stringWithFormat:@"%@", [Util getTimeForSeconds:[NSNumber numberWithDouble:totalTime]]]];
    [_labelSplit setText:[[Util getSplitStringFromDistance:[NSNumber numberWithInt:totalDist] andTime:[NSNumber numberWithDouble:totalTime]] stringByAppendingString:@" / 500m"]];
    
    

    [_tableView setBackgroundColor:[UIColor clearColor]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_repsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddWorkoutCell";
    AddWorkoutCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Rep *rp = [_repsArray objectAtIndex:indexPath.row];
    
    [cell.labelDistance setText:[NSString stringWithFormat:@"%@", rp.totalDistance]];
    [cell.labelTotalTime setText:[NSString stringWithFormat:@"%@", [Util getTimeForSeconds:rp.totalTime]]];
    
    [cell.labelSplit setText:[Util getSplitStringFromDistance:rp.totalDistance andTime:rp.totalTime]];
    [cell.labelRepNum setText:[[[NSString stringWithFormat:@"%ld", indexPath.row+1] stringByAppendingString:@"/"] stringByAppendingString:[NSString stringWithFormat:@"%lu",(unsigned long)_repsArray.count]]];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

@end

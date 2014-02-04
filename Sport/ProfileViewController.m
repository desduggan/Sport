//
//  ProfileViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/25/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "ProfileViewController.h"
#import "DataManager.h"
#import "Util.h"
#import "Workout.h"
#import "Rep.h"

@interface ProfileViewController () {
    
    NSMutableArray *_workoutList;
    
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UILabel *weeklyMetersLabel;
    __weak IBOutlet UILabel *weeklyWorkoutCountLabel;
    __weak IBOutlet UILabel *weeklyAverageLabel;
    
    __weak IBOutlet UILabel *monthlyMetersLabel;
    __weak IBOutlet UILabel *monthlyWorkoutCountLabel;
    __weak IBOutlet UILabel *monthlyAverageLabel;
    
    __weak IBOutlet UILabel *alltimeMetersLabel;
    __weak IBOutlet UILabel *alltimeWorkoutCountLabel;
    __weak IBOutlet UILabel *alltimeAverageLabel;
    
    
}

@end

@implementation ProfileViewController
@synthesize pageIndex, titleText;

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
	// Do any additional setup after loading the view.
    if (!_workoutList) {
        _workoutList = [[NSMutableArray alloc] init];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar.topItem setTitle:titleText];
    
    _workoutList = [[DataManager sharedInstance] getWorkoutArray];
    
    [dateLabel setText:[Util stringFromDateMMMMDYYYY:[NSDate date]]];
    
    [self setWeeklyValues];
    
    [self setMonthlyValues];
    
    [self setAllTimeValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setWeeklyValues {
    // Get the date of last Sunday
    NSDate *today = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:today];
    int weekday = (int)[comps weekday];
    
    NSDate *lastSunday = [today dateByAddingTimeInterval:-3600*24*(weekday-1)];
    
    double totalMeters = 0.0;
    int totalWorkouts = 0;
    
    for (Workout *w in _workoutList) {
        if ([w.date compare:lastSunday] == NSOrderedDescending) {
            if ([w.date compare:[[NSDate date] dateByAddingTimeInterval:3600*24]] == NSOrderedAscending) {
                int wDist = 0.0;
                for (id r in w.rep) {
                    Rep *rep = (Rep *)r;
                    wDist += rep.totalDistance.doubleValue;
                }
                totalMeters += wDist;
                totalWorkouts += 1;
            }
        }
    }
    
    [weeklyMetersLabel setText:[NSString stringWithFormat:@"%d", (int)totalMeters]];
    [weeklyWorkoutCountLabel setText:[NSString stringWithFormat:@"%d", totalWorkouts]];
    int average = (totalMeters == 0) ? (average = 0) : (totalMeters / totalWorkouts);
    [weeklyAverageLabel setText:[NSString stringWithFormat:@"%d", average]];
}


- (void)setMonthlyValues {
    NSDate *today = [NSDate date];
    
    NSDate *first = [today dateByAddingTimeInterval:-3600*24*28];
    
    double totalMeters = 0.0;
    int totalWorkouts = 0;
    
    for (Workout *w in _workoutList) {
        if ([w.date compare:first] == NSOrderedDescending) {
            if ([w.date compare:[[NSDate date] dateByAddingTimeInterval:3600*24]] == NSOrderedAscending) {
                int wDist = 0.0;
                for (id r in w.rep) {
                    Rep *rep = (Rep *)r;
                    wDist += rep.totalDistance.doubleValue;
                }
                totalMeters += wDist;
                totalWorkouts += 1;
            }
        }
    }
    
    [monthlyMetersLabel setText:[NSString stringWithFormat:@"%d", (int)totalMeters]];
    [monthlyWorkoutCountLabel setText:[NSString stringWithFormat:@"%d", totalWorkouts]];
    int average = (totalMeters == 0) ? (average = 0) : (totalMeters / totalWorkouts);
    [monthlyAverageLabel setText:[NSString stringWithFormat:@"%d", average]];
}

- (void)setAllTimeValues {
    
    double totalMeters = 0.0;
    int totalWorkouts = 0;
    
    for (Workout *w in _workoutList) {
        int wDist = 0.0;
        for (id r in w.rep) {
            Rep *rep = (Rep *)r;
            wDist += rep.totalDistance.doubleValue;
        }
        totalMeters += wDist;
        totalWorkouts += 1;
    }
    
    [alltimeMetersLabel setText:[NSString stringWithFormat:@"%d", (int)totalMeters]];
    [alltimeWorkoutCountLabel setText:[NSString stringWithFormat:@"%d", totalWorkouts]];
    int average = (totalMeters == 0) ? (average = 0) : (totalMeters / totalWorkouts);
    [alltimeAverageLabel setText:[NSString stringWithFormat:@"%d", average]];
}











@end

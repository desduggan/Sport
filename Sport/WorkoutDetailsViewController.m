//
//  WorkoutDetailsViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/23/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "WorkoutDetailsViewController.h"
#import "DateSelectionViewController.h"
#import "Util.h"
#import "Workout.h"
#import "Rep.h"
#import "AppDelegate.h"
#import "DataManager.h"
#import "RepHandle.h"

@interface WorkoutDetailsViewController () {
    
    __weak IBOutlet UITextField *labelWorkoutName;
    __weak IBOutlet UITextField *labelSplitLength;
    __weak IBOutlet UIButton *_dateButton;
}

@end

@implementation WorkoutDetailsViewController
@synthesize date, repsArray, workoutName, workoutType;

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
    [labelWorkoutName becomeFirstResponder];
    
    if (!date) {
        [_dateButton setTitle:[Util stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    }
    else {
        [_dateButton setTitle:[Util stringFromDate:date] forState:UIControlStateNormal];
    }
    
    if (workoutName) {
        [labelWorkoutName setText:workoutName];
    }
    else {
        [labelWorkoutName setText:[@"Workout from " stringByAppendingString:[Util stringFromDate:date]]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [labelWorkoutName becomeFirstResponder];

    if (!date) {
        [_dateButton setTitle:[Util stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    }
    else {
        [_dateButton setTitle:[Util stringFromDate:date] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"dateSelect"]) {
        DateSelectionViewController *controller = (DateSelectionViewController *) segue.destinationViewController;
        [controller setDelegate:self];
    }
}


- (void)saveWorkout {
    //  1
    Workout * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Workout"inManagedObjectContext:[DataManager sharedInstance].managedObjectContext];
    //  2
    newEntry.name = labelWorkoutName.text;
    newEntry.location = @"Unknown";
    newEntry.date = [Util dateFromString:_dateButton.titleLabel.text];
    newEntry.sport = @"Rowing";
    newEntry.wid = @"1234";
    newEntry.type = [NSNumber numberWithInteger:workoutType];
    
    for (RepHandle *r in repsArray) {
        Rep * rNew = [NSEntityDescription insertNewObjectForEntityForName:@"Rep"inManagedObjectContext:[DataManager sharedInstance].managedObjectContext];
        [rNew setTotalDistance:r.totalDistance];
        [rNew setTotalTime:r.totalSeconds];
        [rNew setRid:@"unknown-id"];
        [rNew setWorkout:newEntry];
        [newEntry addRepObject:rNew];
    }
    
    //  3
    NSError *error;
    NSLog(@"New workout saving");
    if (![[DataManager sharedInstance].managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    // Reload the data in the DataManager
    [[DataManager sharedInstance] fetchWorkouts];
    [self closeAll];
}

- (void) closeAll {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneBtnPressed:(id)sender {
    [self saveWorkout];
    
}




@end

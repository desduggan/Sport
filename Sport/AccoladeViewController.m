//
//  AccoladeViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/28/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "AccoladeViewController.h"
#import "Workout.h"
#import "Rep.h"
#import "DataManager.h"
#import "Util.h"
#import <math.h>

@interface AccoladeViewController () {
    
    __weak IBOutlet UIPickerView *_workoutPicker;

    NSMutableArray *_targetWorkouts;
    
    NSMutableArray *_workoutList;
    __weak IBOutlet UILabel *baselineSplit;
    __weak IBOutlet UILabel *predictedSplit;
    
    NSInteger baselineIndex;
    NSInteger targetIndex;
    
}

@end

@implementation AccoladeViewController
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
    
    if (!_workoutList) {
        _workoutList = [[NSMutableArray alloc] init];
    }
    if (!_targetWorkouts) {
        _targetWorkouts = [[NSMutableArray alloc] initWithObjects:@"500", @"2000", @"5000", @"6000", @"10000", @"15000", nil];
    }
    
    baselineIndex = 0;
    targetIndex = 0;
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar.topItem setTitle:titleText];
    [self getWorkoutsForPaul];
    [self updateSplits];
    [_workoutPicker selectRow:0 inComponent:0 animated:YES];
    [_workoutPicker selectRow:0 inComponent:1 animated:YES];
}

- (void)getWorkoutsForPaul {
    NSMutableArray *allWorkouts = [[DataManager sharedInstance] getWorkoutArray];
    NSMutableArray *paulsWorkouts = [[NSMutableArray alloc] init];
    
    for (Workout *w in allWorkouts) {
        NSArray *set = [NSArray arrayWithArray:[w.rep allObjects]];
        if (set.count == 1) {
            Rep *r = [set objectAtIndex:0];
            switch (r.totalDistance.intValue) {
                case 1000:
                    [paulsWorkouts addObject:w];
                    break;
                case 2000:
                    [paulsWorkouts addObject:w];
                    break;
                case 4000:
                    [paulsWorkouts addObject:w];
                    break;
                case 5000:
                    [paulsWorkouts addObject:w];
                    break;
                case 6000:
                    [paulsWorkouts addObject:w];
                    break;
                case 10000:
                    [paulsWorkouts addObject:w];
                    break;
                default:
                    break;
            }
            switch (r.totalTime.intValue) {
                case 3600:
                    [paulsWorkouts addObject:w];
                    break;
                case 1200:
                    [paulsWorkouts addObject:w];
                    break;
                case 1800:
                    [paulsWorkouts addObject:w];
                    break;
                default:
                    break;
            }
        }
    
    }
    _workoutList = paulsWorkouts;
    [_workoutList sortUsingSelector:@selector(compareByDate:)];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _workoutList.count;
    }
    else {
        return _targetWorkouts.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        Workout *w = [_workoutList objectAtIndex:row];
        return [[w.name stringByAppendingString:@" "] stringByAppendingString:[Util stringFromDate:w.date]];
    }
    else {
        return [_targetWorkouts objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch(component) {
        case 0: return 250;
        case 1: return 70;
        default: return 64;
    }
    
    return 64;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    
    retval.font = [UIFont systemFontOfSize:16];
    
    if (component == 0) {
        Workout *w = [_workoutList objectAtIndex:row];
        [retval setText:[[w.name stringByAppendingString:@" "] stringByAppendingString:[Util stringFromDate:w.date]]];
    }
    else {
        [retval setText: [[_targetWorkouts objectAtIndex:row] stringByAppendingString:@"m"]];
    }
    return retval;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        baselineIndex = row;
    }
    else {
        targetIndex = row;
    }
    
    [self updateSplits];
    
    
    

    
}


- (void) updateSplits {
    if (_workoutList.count == 0) {
        [baselineSplit setText:@"---"];
        [predictedSplit setText:@"---"];
        return;
    }
    
    Workout *w = [_workoutList objectAtIndex:baselineIndex];
    float totalDist = 0.0;
    double totalTime = 0.0;
    NSMutableArray *repsArray = [[NSMutableArray alloc] init];
    for (id r in w.rep) {
        Rep *rep = (Rep *)r;
        [repsArray addObject:rep];
        totalDist += rep.totalDistance.floatValue;
        totalTime += rep.totalTime.doubleValue;
    }
    [baselineSplit setText:[Util getSplitStringFromDistance:[NSNumber numberWithInt:totalDist] andTime:[NSNumber numberWithDouble:totalTime]] ];
    
    double numberOfSplits = totalDist / 500.0;
    double baselineSplitSeconds = totalTime / numberOfSplits;
    
    //    5*(LN(J22/J21)/LN(2))
    
    NSString *targetString = [_targetWorkouts objectAtIndex:targetIndex];
    float predictionDistance = targetString.floatValue;
    
    double predictionDiff = (log((predictionDistance / totalDist)) / log(2.0)) * 5;
    
    double predictedTime = baselineSplitSeconds + predictionDiff;
    
    [predictedSplit setText:[Util getSplitForSeconds:[NSNumber numberWithDouble:predictedTime]]];
    
    
}

@end

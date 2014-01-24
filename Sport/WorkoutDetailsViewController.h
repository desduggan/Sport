//
//  WorkoutDetailsViewController.h
//  Sport
//
//  Created by Desmond Duggan on 1/23/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "Constant.h"

@interface WorkoutDetailsViewController : UIViewController

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSMutableArray *repsArray;
@property (copy) NSString *workoutName;
@property (nonatomic) WorkoutType workoutType;

@end

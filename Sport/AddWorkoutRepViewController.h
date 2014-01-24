//
//  AddWorkoutRepViewController.h
//  Sport
//
//  Created by Desmond Duggan on 1/22/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface AddWorkoutRepViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property WorkoutType workoutType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSString *repValue;
@property (nonatomic, strong) NSNumber *repCount;
@end

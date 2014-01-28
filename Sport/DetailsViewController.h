//
//  DetailsViewController.h
//  Sport
//
//  Created by Desmond Duggan on 1/26/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@interface DetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Workout *workout;

@end

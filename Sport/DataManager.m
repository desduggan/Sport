//
//  DataManager.m
//  Sport
//
//  Created by Desmond Duggan on 1/24/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@implementation DataManager {
    NSMutableArray *_workoutList;
}


@synthesize managedObjectContext;

- (id)init
{
    self = [super init];
    if (self) {
        //1
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        //2
        self.managedObjectContext = appDelegate.managedObjectContext;
        
        [self fetchWorkouts];
    }
    return self;
}

- (NSMutableArray *)getWorkoutArray {
    if (_workoutList) {
        return _workoutList;
    }
    else {
        return nil;
    }
}


+ (DataManager *)sharedInstance {
    static DataManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)fetchWorkouts {
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Workout"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
//    NSLog(@"App Delegate found the following items: \n%@", fetchedRecords);
    
    // update the instance member variable
    _workoutList = [NSMutableArray arrayWithArray:fetchedRecords];
//    return [NSMutableArray arrayWithArray:fetchedRecords];
}

@end

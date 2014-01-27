//
//  DataManager.h
//  Sport
//
//  Created by Desmond Duggan on 1/24/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (DataManager *)sharedInstance;

- (NSMutableArray *)getWorkoutArray;
- (void)fetchWorkouts;

@end

//
//  Workout.h
//  Sport
//
//  Created by Desmond Duggan on 1/24/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Rep;

@interface Workout : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * sport;
@property (nonatomic, retain) NSString * wid;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *rep;
@end

@interface Workout (CoreDataGeneratedAccessors)

- (void)addRepObject:(Rep *)value;
- (void)removeRepObject:(Rep *)value;
- (void)addRep:(NSSet *)values;
- (void)removeRep:(NSSet *)values;

- (NSComparisonResult)compareByDate:(Workout*)other;

@end

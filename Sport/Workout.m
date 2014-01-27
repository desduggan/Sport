//
//  Workout.m
//  Sport
//
//  Created by Desmond Duggan on 1/24/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "Workout.h"
#import "Rep.h"


@implementation Workout

@dynamic name;
@dynamic location;
@dynamic date;
@dynamic sport;
@dynamic wid;
@dynamic type;
@dynamic rep;


- (NSComparisonResult)compareByDate:(Workout*)other {
    if ([self.date compare:other.date] == NSOrderedDescending) {
        return NSOrderedAscending;
    }
    else if ([self.date compare:other.date] == NSOrderedAscending) {
        return NSOrderedDescending;
    }
    else {
        return NSOrderedSame;
    }
}

@end

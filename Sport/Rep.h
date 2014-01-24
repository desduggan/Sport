//
//  Rep.h
//  Sport
//
//  Created by Desmond Duggan on 1/24/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Rep : NSManagedObject

@property (nonatomic, retain) NSNumber * totalDistance;
@property (nonatomic, retain) NSNumber * totalTime;
@property (nonatomic, retain) NSString * rid;
@property (nonatomic, retain) NSManagedObject *workout;

@end

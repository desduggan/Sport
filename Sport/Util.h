//
//  Util.h
//  Sport
//
//  Created by Desmond Duggan on 1/21/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+(NSNumber *)getSecondsFromTimeString:(NSString *) string;

+ (NSNumber *)getSecondsFromTimeStringWithDecimal:(NSString *)string;

+ (NSString *)getSplitForSeconds:(NSNumber *)seconds;

+ (NSString *)getTimeForSeconds:(NSNumber*)seconds;

+(NSString *)getSplitStringFromDistance:(NSNumber *)dist andTime:(NSNumber *)time;


// Date stuff
+(NSString *)stringFromDate:(NSDate *)date;
+(NSDate *)dateFromString:(NSString *)string;
+(NSString *)stringFromDateMMYY:(NSDate *)date;
+(NSDate *)dateFromStringMMYY:(NSString *)dateString;
+(NSString *)stringFromDateMMMMDYYYY:(NSDate *)date;
+(NSString *)stringFromDateWithDayOfWeek:(NSDate *)date;

@end

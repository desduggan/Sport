//
//  Util.m
//  Sport
//
//  Created by Desmond Duggan on 1/21/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSNumber *)getSecondsFromTimeString:(NSString *)string {
    NSArray *comps = [string componentsSeparatedByString:@":"];
    int minutes = [comps[0] intValue];
    int seconds = [comps[1] intValue];
    
    double totalTime = 60*minutes + seconds;
    return [NSNumber numberWithDouble:totalTime];
}

+ (NSNumber *)getSecondsFromTimeString:(NSString *)string withDec:(BOOL)dec {
    NSArray *comps = [string componentsSeparatedByString:@":"];
    int minutes = [comps[0] intValue];
    NSArray *othercomps = [comps[1] componentsSeparatedByString:@"."];
    int seconds = [othercomps[0] intValue];
    int decimal = [othercomps[1] intValue];
    
    double totalTime = 60*minutes + seconds + 0.1*decimal;
    return [NSNumber numberWithDouble:totalTime];
}

+ (NSString *)getSplitForSeconds:(NSNumber *)seconds {
    int minute = seconds.doubleValue / 60;
    int second = seconds.doubleValue - (minute*60);
    int decimal = ((int)(seconds.doubleValue*10.0)) % 10;
    
    NSString *splitString = [NSString stringWithFormat:@"%d",minute];
    
    if (second < 10) {
        return [splitString stringByAppendingFormat:@":0%d.%d",second,decimal];
    }
    else {
        return [splitString stringByAppendingFormat:@":%d.%d",second,decimal];
    }
}

+ (NSString *)getTimeForSeconds:(NSNumber*)seconds {
    int minute = seconds.doubleValue / 60;
    int second = seconds.doubleValue - (minute*60);
    //    int decimal = ((int)(seconds.doubleValue*10.0)) % 10;
    
    NSString *splitString = [NSString stringWithFormat:@"%d",minute];
    
    if (second < 10) {
        return [splitString stringByAppendingFormat:@":0%d",second];
    }
    else {
        return [splitString stringByAppendingFormat:@":%d",second];
    }
}

+(NSString *)getSplitStringFromDistance:(NSNumber *)dist andTime:(NSNumber *)time {
    double numberOfSplits = dist.doubleValue / 500.0;
    double split = time.doubleValue / numberOfSplits;
    int minute = split / 60;
    int seconds = split - (minute*60);
    int decimal = ((int)(split*10.0)) % 10;
    
    NSString *splitString = [NSString stringWithFormat:@"%d",minute];
    
    if (seconds < 10) {
        return [[splitString stringByAppendingFormat:@":0%d",seconds] stringByAppendingFormat:@".%d",decimal];
    }
    else {
        return [[splitString stringByAppendingFormat:@":%d",seconds] stringByAppendingFormat:@".%d",decimal];
    }
}

@end

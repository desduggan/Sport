//
//  HistoryCell.m
//  Sport
//
//  Created by Desmond Duggan on 1/24/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell
@synthesize labelAverageSplit, labelDate, labelLocation, labelName, labelTotalMeters, labelTotalTime;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

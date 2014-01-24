//
//  HistoryCell.h
//  Sport
//
//  Created by Desmond Duggan on 1/24/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalMeters;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalTime;
@property (weak, nonatomic) IBOutlet UILabel *labelAverageSplit;

@end

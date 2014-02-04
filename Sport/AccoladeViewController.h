//
//  AccoladeViewController.h
//  Sport
//
//  Created by Desmond Duggan on 1/28/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccoladeViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property NSUInteger pageIndex;
@property NSString *titleText;

@end


//
//  RootViewController.h
//  Sport
//
//  Created by Desmond Duggan on 1/23/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;


@end

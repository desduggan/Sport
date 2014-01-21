//
//  SplashViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/20/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "SplashViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SplashViewController () {
    
    __weak IBOutlet UIButton *gettingStartedBtn;
}

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [gettingStartedBtn.layer setBorderWidth:2.0];

    [gettingStartedBtn.layer setBorderColor:[UIColor colorWithRed:184.0/255.0 green:76.0/255.0 blue:65.0/255.0 alpha:1.0].CGColor];
    
    [gettingStartedBtn.layer setCornerRadius:5.0f];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

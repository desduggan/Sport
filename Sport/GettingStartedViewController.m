//
//  GettingStartedViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/20/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "GettingStartedViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GettingStartedViewController () {
    
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *ageField;
    __weak IBOutlet UITextField *weightField;
    __weak IBOutlet UISegmentedControl *genderSwitch;
}

@end

@implementation GettingStartedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the nav bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:65.0/255.0 green:65.0/255.0 blue:65.0/255.0 alpha:1.0]];
    
    
	// Do any additional setup after loading the view.
    UIView *namePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    [nameField setLeftView:namePaddingView];
    [nameField setLeftViewMode:UITextFieldViewModeAlways];
    
    UIView *agePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    [ageField setLeftView:agePaddingView];
    [ageField setLeftViewMode:UITextFieldViewModeAlways];

    UIView *weightPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    [weightField setLeftView:weightPaddingView];
    [weightField setLeftViewMode:UITextFieldViewModeAlways];
    
    // Have the user's cursor go right to the name field.
    [nameField becomeFirstResponder];
    
//    [nameField.layer setBorderWidth:2.0f];
//    [nameField.layer setBorderColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0].CGColor];
//    nameField.layer.masksToBounds = YES;
//    [nameField.layer setCornerRadius:3.0f];
//    [nameField setTextColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

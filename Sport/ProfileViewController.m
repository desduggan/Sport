//
//  ProfileViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/25/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize pageIndex, titleText;

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
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar.topItem setTitle:titleText];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar.topItem setTitle:titleText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

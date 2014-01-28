//
//  AccoladeViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/28/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "AccoladeViewController.h"

@interface AccoladeViewController ()

@end

@implementation AccoladeViewController
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

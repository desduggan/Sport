//
//  DetailsViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/26/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController () {
    __weak IBOutlet UIView *_topView;
    
}

@end

@implementation DetailsViewController

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
    
    [_topView.layer setShadowOffset:CGSizeMake(1, 1)];
    [_topView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_topView.layer setShadowRadius:4.0];
    [_topView.layer setShadowOpacity:.8f];
    [_topView.layer setShadowPath:[[UIBezierPath bezierPathWithRect:_topView.layer.bounds] CGPath]];
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

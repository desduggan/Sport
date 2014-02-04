//
//  DateSelectionViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/23/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "DateSelectionViewController.h"
#import "Util.h"

@interface DateSelectionViewController () {
    
    __weak IBOutlet UILabel *_labelDate;
    __weak IBOutlet UIDatePicker *_datePicker;
}

@end

@implementation DateSelectionViewController
@synthesize delegate;

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
    [_labelDate setText:[Util stringFromDate:[NSDate date]]];
    [_datePicker setMaximumDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)datePickerChanged:(id)sender {
    [_labelDate setText:[Util stringFromDate:[_datePicker date]]];
}

- (IBAction)doneBtnPressed:(id)sender {
    NSDate *dt = [Util dateFromString:_labelDate.text];
    [delegate setDate:dt];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end

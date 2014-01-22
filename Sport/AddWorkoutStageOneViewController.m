//
//  AddWorkoutStageOneViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/21/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "AddWorkoutStageOneViewController.h"
#import "AddWorkoutRepViewController.h"
#import "Constant.h"
#import "Util.h"

@interface AddWorkoutStageOneViewController () {
    
    // 0 index is time, 1 index is distance
    __weak IBOutlet UISegmentedControl *_workoutTypeSwitch;
    __weak IBOutlet UITextField *_repCountField;
    __weak IBOutlet UITextField *_repValueField;
    int _valueDigitCounter;
}

@end

@implementation AddWorkoutStageOneViewController

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
    [_repCountField becomeFirstResponder];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    _valueDigitCounter = 0;
}


- (IBAction)selectorPressed:(id)sender {
    if (_workoutTypeSwitch.selectedSegmentIndex == 0) {
        [_repValueField setEnabled:YES];
        _valueDigitCounter = 0;
        _repValueField.text = @"";
        _repValueField.placeholder = @"15:00";
    }
    else if (_workoutTypeSwitch.selectedSegmentIndex == 1) {
        [_repValueField setEnabled:YES];
        _valueDigitCounter = 0;
        _repValueField.text = @"";
        _repValueField.placeholder = @"5000";
    }
    else if (_workoutTypeSwitch.selectedSegmentIndex == 2) {
        _repValueField.text = @"??";
        [_repValueField setEnabled:NO];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%@ length=%d location=%d counter=%d", string, range.length, range.location, _valueDigitCounter);
    
    // First text field for number of reps
    if (textField.tag == 100) {
        // must be less than 2
        if (range.length == 0 && textField.text.length >= 2) {
            return NO;
        }
    }
    // Second text field for rep value. Time is selected.
    else if (textField.tag == 101 && _workoutTypeSwitch.selectedSegmentIndex == 0 && range.length == 0) {
        if (textField.text.length == 0) {
            NSString *base = [@"00:0" stringByAppendingString:string];
            [_repValueField setText:base];
            _valueDigitCounter += 1;
            return NO;
        }
        else if (_valueDigitCounter == 1) {
            NSRange lastChars = {4,1};
            NSString *oldStr = [_repValueField.text substringWithRange:lastChars];
            NSString *base = [[@"00:" stringByAppendingString:oldStr] stringByAppendingString:string];
            [_repValueField setText:base];
            _valueDigitCounter += 1;
            return NO;
        }
        else if (_valueDigitCounter == 2) {
            NSRange r2 = {3,1};
            NSRange r1 = {4,1};
            
            NSString *dig1 = [_repValueField.text substringWithRange:r1];
            NSString *dig2 = [_repValueField.text substringWithRange:r2];
            NSString *base = [[[[@"0" stringByAppendingString:dig2] stringByAppendingString:@":"] stringByAppendingString:dig1] stringByAppendingString:string];
            
            [_repValueField setText:base];
            _valueDigitCounter += 1;
            return NO;
        }
        else if (_valueDigitCounter == 3) {
            NSRange r3 = {1,1};
            NSRange r2 = {3,1};
            NSRange r1 = {4,1};
            
            
            NSString *dig1 = [_repValueField.text substringWithRange:r1];
            NSString *dig2 = [_repValueField.text substringWithRange:r2];
            NSString *dig3 = [_repValueField.text substringWithRange:r3];
            NSString *base = [[[[dig3 stringByAppendingString:dig2] stringByAppendingString:@":"] stringByAppendingString:dig1] stringByAppendingString:string];
            
            [_repValueField setText:base];
            _valueDigitCounter += 1;
            return NO;
        }
        else if (_valueDigitCounter >= 4) {
            return NO;
        }
    }
    // Deal with deletions. Rep value editing and time selected.
    else if (textField.tag == 101 && _workoutTypeSwitch.selectedSegmentIndex == 0 && range.length == 1) {

        if (_valueDigitCounter == 4) {
            NSString *dig0 = [_repValueField.text substringWithRange:(NSRange){0,1}];
            NSString *dig1 = [_repValueField.text substringWithRange:(NSRange){1,1}];
            NSString *dig2 = [_repValueField.text substringWithRange:(NSRange){3,1}];

            NSString *base = [[[[@"0" stringByAppendingString:dig0] stringByAppendingString:@":"] stringByAppendingString:dig1] stringByAppendingString:dig2];
            
            [_repValueField setText:base];
            _valueDigitCounter -= 1;
            return NO;
        }
        else if (_valueDigitCounter == 3) {
            NSString *dig1 = [_repValueField.text substringWithRange:(NSRange){1,1}];
            NSString *dig2 = [_repValueField.text substringWithRange:(NSRange){3,1}];
            
            NSString *base = [[@"00:" stringByAppendingString:dig1] stringByAppendingString:dig2];
            
            [_repValueField setText:base];
            _valueDigitCounter -= 1;
            return NO;
        }
        else if (_valueDigitCounter == 2) {
            NSString *dig2 = [_repValueField.text substringWithRange:(NSRange){3,1}];
            
            NSString *base = [@"00:0" stringByAppendingString:dig2];
            
            [_repValueField setText:base];
            _valueDigitCounter -= 1;
            return NO;
        }
        else if (_valueDigitCounter == 1) {
            [_repValueField setText:@""];
            _valueDigitCounter -= 1;
            return NO;
        }
    }
    // distance is selected
    else if (textField.tag == 101 && _workoutTypeSwitch.selectedSegmentIndex == 1 && range.length == 0) {
        if (textField.text.length >= 5) {
            return NO;
        }
    }

    
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addWorkout"]) {
        AddWorkoutRepViewController *controller = (AddWorkoutRepViewController *)segue.destinationViewController;
        
        if (_workoutTypeSwitch.selectedSegmentIndex == 0) {
            [controller setWorkoutType:wTime];
            [controller setTitle:@"Time Workout"];
            [controller setRepValue:_repValueField.text];
            [controller setRepCount:[NSNumber numberWithInt: _repCountField.text.integerValue]];
        }
        else if (_workoutTypeSwitch.selectedSegmentIndex == 1) {
            [controller setWorkoutType:wDistance];
            [controller setTitle:@"Distance Workout"];
            [controller setRepValue:_repValueField.text];
            [controller setRepCount:[NSNumber numberWithInt: _repCountField.text.integerValue]];
        }
        else {
            [controller setWorkoutType:wCustom];
            [controller setTitle:@"Custom Workout"];
        }
    }
}

@end

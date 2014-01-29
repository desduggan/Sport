//
//  AddWorkoutRepViewController.m
//  Sport
//
//  Created by Desmond Duggan on 1/22/14.
//  Copyright (c) 2014 Desmond Duggan. All rights reserved.
//

#import "AddWorkoutRepViewController.h"
#import "Constant.h"
#import "RepHandle.h"
#import "Util.h"
#import "AddWorkoutCell.h"
#import "WorkoutDetailsViewController.h"

@interface AddWorkoutRepViewController () {
    
    __weak IBOutlet UILabel *_pageTitle;
    __weak IBOutlet UILabel *_pageDesc;
    __weak IBOutlet UITextField *_repValueField;
    int _valueDigitCounter;
    
    NSMutableArray *_repsArray;
    __weak IBOutlet UITableView *_tableview;
    
    
    __weak IBOutlet UILabel *_errorLabel;
    
}

@end

@implementation AddWorkoutRepViewController
@synthesize title, workoutType, repValue, repCount;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    // Init stuff
    
    
    [_pageTitle setText:title];
    if (workoutType == wTime) {
        NSString *str = [[@"Input the distance for each timed rep of " stringByAppendingString:repValue] stringByAppendingString:@" minutes"];
        [_repValueField setPlaceholder:@"5000"];
        [_pageDesc setText:str];
    }
    else if (workoutType == wDistance) {
        NSString *str = [[@"Input the time for each distance rep of " stringByAppendingString:repValue] stringByAppendingString:@" meters."];
        [_repValueField setPlaceholder:@"15:00"];
        [_pageDesc setText:str];
    }
    else if (workoutType == wCustom) {
        [_pageDesc setText:@"Input the time and distance for each rep."];
        
    }
    else {
        NSLog(@"Error in viewwillapear for stage 2 add workout");
    }
    [_repValueField becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_repsArray) {
        _valueDigitCounter = 0;
        _repsArray = [[NSMutableArray alloc] init];
    }
    
    [_tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addBtnPressed:(id)sender {
    if ([_repValueField.text isEqualToString:@""]) {
        [_errorLabel setText: @"Please enter a valid time."];
        return;
    }
    if (_repsArray.count >= repCount.intValue) {
        NSString *error = [[@"You've already added " stringByAppendingString:[NSString stringWithFormat:@"%d", repCount.intValue]]stringByAppendingString:@" reps."];
        [_errorLabel setText: error];
        return;
    }
    if (_valueDigitCounter < 4 && workoutType == wDistance) {
        [_errorLabel setText: @"Please enter a valid time."];
        return;
    }
    
    
    else if (workoutType == wTime) {
        NSNumber *secs = [Util getSecondsFromTimeString:repValue];
        NSNumber *distance = [NSNumber numberWithInteger:_repValueField.text.integerValue];
        
        RepHandle *hndl = [[RepHandle alloc] init];
        [hndl setTotalSeconds:secs];
        [hndl setTotalDistance:distance];
        [_repsArray addObject:hndl];
        
        
//        [_tableview reloadData];
        
        [_tableview beginUpdates];
        NSArray *arr = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:_repsArray.count-1 inSection:0], nil];
        [_tableview insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationMiddle];
        [_tableview endUpdates];
    }
    else if (workoutType == wDistance) {
        NSNumber *secs;
        if (_valueDigitCounter == 4) {
            secs = [Util getSecondsFromTimeString:_repValueField.text];
        }
        else {
            secs = [Util getSecondsFromTimeStringWithDecimal:_repValueField.text];
        }
        NSNumber *distance = [NSNumber numberWithFloat:repValue.floatValue];
        
        RepHandle *hndl = [[RepHandle alloc] init];
        [hndl setTotalSeconds:secs];
        [hndl setTotalDistance:distance];
        [_repsArray addObject:hndl];
        
//        [_tableview reloadData];
        
        [_tableview beginUpdates];
        NSArray *arr = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:_repsArray.count-1 inSection:0], nil];
        [_tableview insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationMiddle];
        [_tableview endUpdates];
    }
    else {
        return;
    }
    [_repValueField setText:@""];
    _valueDigitCounter = 0;
    [_errorLabel setText: @""];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_repsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddWorkoutCell";
    AddWorkoutCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    RepHandle *hndl = [_repsArray objectAtIndex:indexPath.row];
    
    [cell.labelDistance setText:[NSString stringWithFormat:@"%@", hndl.totalDistance]];
    [cell.labelTotalTime setText:[NSString stringWithFormat:@"%@", [Util getSplitForSeconds:hndl.totalSeconds]]];
    [cell.labelSplit setText:[Util getSplitStringFromDistance:hndl.totalDistance andTime:hndl.totalSeconds]];
    [cell.labelRepNum setText:[[[NSString stringWithFormat:@"%d", indexPath.row+1] stringByAppendingString:@"/"] stringByAppendingString:[NSString stringWithFormat:@"%d",repCount.intValue]]];
    
    return cell;
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
     
     return YES;
 }



 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         // Delete the row from the data source
         [_repsArray removeObjectAtIndex:indexPath.row];
         _valueDigitCounter = 0;
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.3];
     }
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
 }

- (void)reloadTable {
    [_tableview reloadData];
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */







- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // Second text field for rep value. Time is selected.
    if (textField.tag == 101 && workoutType == wDistance && range.length == 0) {
        if (textField.text.length == 0) {
            _valueDigitCounter += 1;
            return YES;
        }
        else if (_valueDigitCounter == 1) {
            _valueDigitCounter += 1;
            return YES;
        }
        else if (_valueDigitCounter == 2) {
            if (string.intValue > 5) {
                return NO;
            }
            
            NSRange rng = {0,2};
            
            NSString *firstHalf = [_repValueField.text substringWithRange:rng];
            NSString *base = [[firstHalf stringByAppendingString:@":"] stringByAppendingString:string];
            
            [_repValueField setText:base];
            _valueDigitCounter += 1;
            return NO;
        }
        else if (_valueDigitCounter == 3) {
            _valueDigitCounter += 1;
            return YES;
        }
        else if (_valueDigitCounter == 4) {
            NSRange rng = {0,5};
            
            NSString *firstHalf = [_repValueField.text substringWithRange:rng];
            NSString *base = [[firstHalf stringByAppendingString:@"."] stringByAppendingString:string];
            [_repValueField setText:base];
            _valueDigitCounter += 1;
            return NO;
        }
        else if (_valueDigitCounter >= 5) {
            return NO;
        }
    }
//    if (textField.tag == 101 && workoutType == wDistance && range.length == 0) {
//        if (textField.text.length == 0) {
//            NSString *base = [@"00:0" stringByAppendingString:string];
//            [_repValueField setText:base];
//            _valueDigitCounter += 1;
//            return NO;
//        }
//        else if (_valueDigitCounter == 1) {
//            NSRange lastChars = {4,1};
//            NSString *oldStr = [_repValueField.text substringWithRange:lastChars];
//            NSString *base = [[@"00:" stringByAppendingString:oldStr] stringByAppendingString:string];
//            [_repValueField setText:base];
//            _valueDigitCounter += 1;
//            return NO;
//        }
//        else if (_valueDigitCounter == 2) {
//            NSRange r2 = {3,1};
//            NSRange r1 = {4,1};
//            
//            NSString *dig1 = [_repValueField.text substringWithRange:r1];
//            NSString *dig2 = [_repValueField.text substringWithRange:r2];
//            NSString *base = [[[[@"0" stringByAppendingString:dig2] stringByAppendingString:@":"] stringByAppendingString:dig1] stringByAppendingString:string];
//            
//            [_repValueField setText:base];
//            _valueDigitCounter += 1;
//            return NO;
//        }
//        else if (_valueDigitCounter == 3) {
//            NSRange r3 = {1,1};
//            NSRange r2 = {3,1};
//            NSRange r1 = {4,1};
//            
//            
//            NSString *dig1 = [_repValueField.text substringWithRange:r1];
//            NSString *dig2 = [_repValueField.text substringWithRange:r2];
//            NSString *dig3 = [_repValueField.text substringWithRange:r3];
//            NSString *base = [[[[dig3 stringByAppendingString:dig2] stringByAppendingString:@":"] stringByAppendingString:dig1] stringByAppendingString:string];
//            
//            [_repValueField setText:base];
//            _valueDigitCounter += 1;
//            return NO;
//        }
//        else if (_valueDigitCounter >= 4) {
//            NSRange r3 = {1,1};
//            NSRange r2 = {3,1};
//            NSRange r1 = {4,1};
//            
//            
//            NSString *dig1 = [_repValueField.text substringWithRange:r1];
//            NSString *dig2 = [_repValueField.text substringWithRange:r2];
//            NSString *dig3 = [_repValueField.text substringWithRange:r3];
//            NSString *base = [[[[dig3 stringByAppendingString:dig2] stringByAppendingString:@":"] stringByAppendingString:dig1] stringByAppendingString:string];
//            
//            [_repValueField setText:base];
//            _valueDigitCounter += 1;
//            return NO;
//        }
//        else if (_valueDigitCounter >= 5) {
//            return NO;
//        }
//    }
    // Deal with deletions. Rep value editing and time selected.
    else if (textField.tag == 101 && workoutType == wDistance && range.length == 1) {
        
        if (_valueDigitCounter == 5) {
            NSString *base = [_repValueField.text substringWithRange:(NSRange){0,5}];
            [_repValueField setText:base];
            _valueDigitCounter -= 1;
            return NO;
        }
        else if (_valueDigitCounter == 4) {
            _valueDigitCounter -= 1;
            return YES;
        }
        else if (_valueDigitCounter == 3) {
            NSString *base = [_repValueField.text substringWithRange:(NSRange){0,2}];
            [_repValueField setText:base];
            _valueDigitCounter -= 1;
            return NO;
        }
        else if (_valueDigitCounter == 2) {
            _valueDigitCounter -= 1;
            return YES;
        }
        else if (_valueDigitCounter == 1) {
            [_repValueField setText:@""];
            _valueDigitCounter -= 1;
            return NO;
        }
    }
    // distance is selected
    else if (textField.tag == 101 && workoutType == wTime && range.length == 0) {
        if (textField.text.length >= 5) {
            return NO;
        }
    }
    
    
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"workoutDetails"]) {
        WorkoutDetailsViewController *controller = (WorkoutDetailsViewController *) segue.destinationViewController;
        [controller setRepsArray:_repsArray];
        NSString *name = [[[NSString stringWithFormat:@"%d",repCount.integerValue] stringByAppendingString:@" x "] stringByAppendingString:repValue];
        [controller setWorkoutName:name];
        [controller setWorkoutType:workoutType];
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"workoutDetails"]) {
        if (_repsArray.count != repCount.integerValue) {
            return NO;
        }
    }
    return YES;
}



@end

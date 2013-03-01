//
//  QuizViewController.m
//  Quiz
//
//  Created by Dina Li on 1/11/13.
//  Copyright (c) 2013 USDA ERS. All rights reserved.
//

#import "QuizViewController.h"
#import "ResponseViewController.h"

@interface QuizViewController ()

@end

@implementation QuizViewController

@synthesize checked = _checked;


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
     _responseLabel.hidden = YES;
    checked = NO;
    _mainQuestionLabel.text = @"Which States have the largest number of food processing plants?";
    _questionOneLabel.text = @"Illinois, Texas, North Carolina";
    _questionTwoLabel.text = @"California, New York, Texas";
    _questionThreeLabel.text = @"Indiana, Louisiana, North Carolina";
    _questionFourLabel.text = @"Nebraska, Wyoming, Kansas";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goOne_send:(id)sender {
     _responseLabel.text = @"Try again";
     _responseLabel.hidden = NO;
    UIColor *errorColor = [UIColor redColor];
    [_responseLabel setTextColor:errorColor];
    
	UIImage *checkImage = (self.checked) ? [UIImage imageNamed:@"stock_draw-circle-unfilled.png"] : [UIImage imageNamed:@"red-circle.png"];
    [ _goOne_button setImage:checkImage forState:UIControlStateNormal];
    
    self.checked = !self.checked;
}

- (IBAction)goTwo_send:(id)sender {
    _responseLabel.text = @"Correct!";
    _responseLabel.hidden = NO;
    UIColor *correctColor = [UIColor greenColor];
    [_responseLabel setTextColor:correctColor];
    
    UIImage *checkImage = (self.checked) ? [UIImage imageNamed:@"stock_draw-circle-unfilled.png"] : [UIImage imageNamed:@"tick-circle-frame.png"];
    [ _goTwo_button setImage:checkImage forState:UIControlStateNormal];
    
    self.checked = !self.checked;

}

- (IBAction)goThree_send:(id)sender {
    _responseLabel.text = @"Try again";
    UIColor *errorColor = [UIColor redColor];
    [_responseLabel setTextColor:errorColor];
    _responseLabel.hidden = NO;
    
	UIImage *checkImage = (self.checked) ? [UIImage imageNamed:@"stock_draw-circle-unfilled.png"] : [UIImage imageNamed:@"tick-circle-frame.png"];
    [ _goThree_button setImage:checkImage forState:UIControlStateNormal];
    
    self.checked = !self.checked;
}

- (IBAction)goFour_send:(id)sender {
    _responseLabel.text = @"Try again";
    UIColor *errorColor = [UIColor redColor];
    [_responseLabel setTextColor:errorColor];
    _responseLabel.hidden = NO;
    
	UIImage *checkImage = (self.checked) ? [UIImage imageNamed:@"stock_draw-circle-unfilled.png"] : [UIImage imageNamed:@"red-circle.png"];
    [ _goFour_button setImage:checkImage forState:UIControlStateNormal];
    
    self.checked = !self.checked;
}

// change the text of the questions and answers, restore to initial state
// TODO: fill from a PList

- (IBAction)next_send:(id)sender {
    _mainQuestionLabel.text = @"Q: Are family farms disappearing?";
    _questionOneLabel.text = @"Yes";
    _questionTwoLabel.text = @"No";
    _goThree_button.hidden = YES;
    _goFour_button.hidden = YES;
    _questionThreeLabel.hidden = YES;
    _questionFourLabel.hidden = YES;
    UIImage *checkImage = [UIImage imageNamed:@"stock_draw-circle-unfilled.png"];
    [ _goOne_button setImage:checkImage forState:UIControlStateNormal];
    [ _goTwo_button setImage:checkImage forState:UIControlStateNormal];
    _responseLabel.hidden = YES;
   
}

- (IBAction)details_send:(id)sender {
    [self performSegueWithIdentifier: @"showDetails" sender: self];
   // UIStoryboardSegue *segue = [[UIStoryboardSegue alloc]init];
   // ResponseViewController *responseViewController = [segue destinationViewController];
   // responseViewController.responseTextView.text = @"you are so smart!";
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
        ResponseViewController *responseViewController = [segue destinationViewController];
        responseViewController.responseTextView.text = @"you are so smart!";

    }
    
    //TODO: somehow the next view needs to show the details for the answer
      //  ResponseViewController.sighting = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
        
}

@end

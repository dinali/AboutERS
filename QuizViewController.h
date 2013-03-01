//
//  QuizViewController.h
//  Quiz
//
//  Created by Dina Li on 1/11/13.
//  Copyright (c) 2013 USDA ERS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController{
    BOOL *checked;
}

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

@property (weak, nonatomic) IBOutlet UILabel *mainQuestionLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionTwoLabel;

@property (weak, nonatomic) IBOutlet UIButton *goOne_button;
@property (weak, nonatomic) IBOutlet UIButton *goTwo_button;
@property (weak, nonatomic) IBOutlet UIButton *goThree_button;
@property (weak, nonatomic) IBOutlet UIButton *goFour_button;

@property (weak, nonatomic) IBOutlet UILabel *questionThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionFourLabel;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;
@property (weak, nonatomic) IBOutlet UIButton *next_button;
@property (assign, nonatomic) BOOL checked;
@property (weak, nonatomic) IBOutlet UIButton *details_button;


- (IBAction)goOne_send:(id)sender;
- (IBAction)goTwo_send:(id)sender;
- (IBAction)goThree_send:(id)sender;
- (IBAction)goFour_send:(id)sender;

- (IBAction)next_send:(id)sender;
- (IBAction)details_send:(id)sender;



@end

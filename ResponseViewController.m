//
//  ResponseViewController.m
//  Quiz
//
//  Created by Dina Li on 1/16/13.
//  Copyright (c) 2013 USDA ERS. All rights reserved.
//

#import "ResponseViewController.h"

@interface ResponseViewController ()

@end

@implementation ResponseViewController

@synthesize responseTextView = _responseTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//- (void)viewWillAppear:(BOOL)animated{
//     _responseTextView.text = @"does this work?";
//    
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *answer = @"California has the largest number of food manufacturing plants, followed by New York and Texas";
    
    _responseTextView.text = answer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

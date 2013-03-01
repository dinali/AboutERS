//
//  NewsDetailViewController.m
//  AboutERS
//
//  Created by Dina Li on 1/29/13.
//  Copyright (c) 2013 ers. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "Record.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

@synthesize detailItem = _detailItem;
@synthesize descriptionTextView = _descriptionTextView;

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    self.title = @"USDA ERS - About ERS";
}

-(void)configureView
{
    if (self.detailItem) {
        Record *feedRecord = self.detailItem;
        
        _descriptionTextView.text = feedRecord.descriptionString;
        NSLog(@"description = %@",_descriptionTextView.text);
    }
}


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
    // [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

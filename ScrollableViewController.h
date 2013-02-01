//
//  ScrollableViewController.h
//  AboutERS
//  Description: test scrolling and pinch to zoom features for Charts of Note
//  TODO: scrolls but image doesn't zoom, problem related to Autolayout in iOS 6
//  Fix this later on because it's a known problem

//  Created by Dina Li on 2/1/13.
//  Copyright (c) 2013 ers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollableViewController : UIViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;

@property(strong, nonatomic) UIImage *chart;
@property(strong, nonatomic) NSString *description;
@property(strong,nonatomic) NSURL *url;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIScrollView *feedScrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

//- (IBAction)handleTapFrom:(UITapGestureRecognizer *)recognizer; // unnecessary

@end

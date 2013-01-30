//
//  NewsDetailViewController.h
//  AboutERS
//
//  Created by Dina Li on 1/29/13.
//  Copyright (c) 2013 ers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong,nonatomic) IBOutlet UITextView * descriptionTextView;

@end

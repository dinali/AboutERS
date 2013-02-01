//
//  apiViewController.h
//  Description: Charts of Note read from Umbraco API; 
//  Features: scrollable with pinch to zoom
//  Created by Dina Li on 1/22/13.
//
//

#import <UIKit/UIKit.h>

@interface apiViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

@end


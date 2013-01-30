//
//  apiViewController.h
//  WSsample
//
//  Created by Dina Li on 1/22/13.
//
//

#import <UIKit/UIKit.h>

@interface apiViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

/*@property (weak, nonatomic) IBOutlet UILabel *JSONlabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UIImageView *chartImageView;
*/
@end


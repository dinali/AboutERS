//
//  TweetTextViewController.h
//  Tabs
//
//  Created by Dina Li on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTextViewController : UIViewController <UIWebViewDelegate>
{
    // IBOutlet UIImageView *profileImage;
    //IBOutlet UILabel *nameLabel;
    IBOutlet UIWebView * tweetWebView;
    //IBOutlet UITextView * tweetTextView;
}
//@property (strong, nonatomic) IBOutlet UIWebView *tweetWebView;
@property (strong, nonatomic) IBOutlet UIWebView *tweetWebView;
@property (strong, nonatomic) id detailItem;

@end

//
//  TwitterViewController.h
//  AboutERS
//  Description: display ERS twitter feed
//  Created by Dina Li on 1/29/13.
//  Copyright (c) 2013 ers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ERSAppDelegate.h"

@interface TwitterViewController : UITableViewController<UIScrollViewDelegate>
{
	NSArray *entries;   // the main data model for our UITableView
    //   NSMutableDictionary *imageDownloadsInProgress;  // the set of IconDownloader objects for each app
}

//@property (strong, nonatomic) ERSDetailViewController *detailViewController;
@property (nonatomic, strong) NSMutableArray *revisedArray;
//@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
//@property(nonatomic,strong)
@property (nonatomic, strong) NSMutableArray *tweetsArray;
@property (nonatomic, strong) ERSAppDelegate *appDelegate;

- (void)fetchTweets;
@end

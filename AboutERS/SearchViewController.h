//
//  SearchViewController.h
//  Search
//
//  Created by Dina Li on 1/9/13.
//  Copyright (c) 2013 USDA ERS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate>
{
    UIWebView *webView;
    UISearchBar *searchBarOne;
}

//@property (strong, nonatomic) IBOutlet UIWebView *webView;
//@property (strong, nonatomic) IBOutlet UISearchBar *searchBarOne;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBarOne;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBarOne;
@end


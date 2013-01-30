//
//  SearchViewController.m
//  Search
//
//  Created by Dina Li on 1/9/13.
//  Copyright (c) 2013 USDA ERS. All rights reserved.
//

//TODO: most but not all(?) of the code for adding the tap to zoom is here

#import "SearchViewController.h"
//#define ZOOM_VIEW_TAG 100
//#define ZOOM_STEP 1.5

@implementation SearchViewController

@synthesize webView = _webView;
@synthesize searchBarOne = _searchBarOne;

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBarOne {
    
    [_searchBarOne resignFirstResponder]; // hide keyboard
}

#pragma mark -
#pragma mark UISearchBarDelegate

// called when the bookmark button inside the search bar is tapped
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    //  NSLog(@"bookmark button clicked");
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchTerm = [_searchBarOne.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    //  NSString *stringURL = [NSString stringWithFormat:@"http://search.usa.gov/search?utf8=✓&sc=1&query=usda+economic+research+service&m=&embedded=&affiliate=usagov&filter=moderate"];
    
    NSString* stringURL = [NSString stringWithFormat:@"http://search.ers.usda.gov/search?affiliate=ers&query=%@",searchTerm];
    
    // NSLog(@"viewDidLoad url = %@", stringURL);
    
    NSString* webStringURL = [stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL* urlFinal = [NSURL URLWithString:webStringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlFinal];
    
    [_webView loadRequest:request];
    
}


//TODO: not implemented
// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	NSLog(@"cancel button clicked");
}

- (void) viewWillAppear:(BOOL)animated
{
    //    _testLabel.text = @"this is a test";
}

// display a page in the UIView on load
- (void)viewDidLoad
{
    _searchBarOne.delegate = self;
	//_searchBarOne.showsCancelButton = YES;
    //_searchBarOne.showsBookmarkButton = YES;
    
    NSURL *url =  [NSURL URLWithString: @"http://www.ers.usda.gov"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // NSLog(@"viewDidLoad url = %@", url);
    
    [_webView loadRequest:request];
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setSearchBarOne:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end


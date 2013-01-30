//
//  TwitterViewController.m
//  AboutERS
//
//  Created by Dina Li on 1/29/13.
//  Copyright (c) 2013 ers. All rights reserved.
//

#import "TwitterViewController.h"
#import "TweetTextViewController.h"
#import "Tweet.h"

#define kCustomRowHeight    80.0

@interface TwitterViewController ()
{
    Tweet *appTweet;
}
@end

@implementation TwitterViewController

@synthesize tweetsArray = _tweetsArray;
@synthesize appDelegate = _appDelegate;
@synthesize revisedArray = _revisedArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchTweets];  // get data
    
    self.tableView.rowHeight = kCustomRowHeight;
    _revisedArray = [[NSMutableArray alloc]init]; //do this once
}

-(void)viewWillAppear:(BOOL)animated
{
      //self.title = @"test";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _tweetsArray.count;
}

// TO DO: clean up this code, break out the URL
-(void)fetchTweets{
    
    NSString * urlToFetch = @"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=USDA_ERS";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:urlToFetch]];
        NSError* error;
        
        _tweetsArray = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:&error];
        
        NSLog (@"fetchTweets: number of elements in array = %u", [_tweetsArray count]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = [_tweetsArray objectAtIndex:indexPath.row];
    
    NSString *description = [tweet objectForKey:@"text"];
    NSString *tweeterName = [[tweet objectForKey:@"user"] objectForKey:@"name"];
    NSString *atSign = @"@";
    NSString *formattedName = [atSign stringByAppendingString:tweeterName];
    
    // http:\/\/t.co\/BUITvE1s  http:\/\/t.co\/4ntOOq9n"
    NSString *link = [self getLink:description];
    
    // create a global Tweet object and store the link
    appTweet = [[Tweet alloc]init ];
    appTweet.appURLString = link;
    appTweet.title = description;
    appTweet.subtitle = formattedName;
    
    // array for the revised tweets to pass to the segue for link
    if(appTweet !=nil)
    {
        [_revisedArray addObject: appTweet];
    }
    
    // style and fill labels
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.textLabel.text = appTweet.title;
    cell.detailTextLabel.text =  appTweet.subtitle;
    
    UIImage *cellImage = [UIImage imageNamed:@"ers_twitter_icon.tiff"];
    cell.imageView.image = cellImage;
    
    //  NSLog (@"Number of elements in array = %u", [_revisedArray count]);
    
    return cell;
}


// extract the links from the tweet
- (NSString *)getLink: (NSString *) input {
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString: input];
    // NSLog(@"input = %@", input);
    
    // find start of tag
    [theScanner scanUpToString: @"http" intoString: NULL];
    if ([theScanner isAtEnd] == NO) {
        
        // might have to adjust the scanLocation, now it only returns one link
        NSInteger newLoc = [theScanner scanLocation] + 20;
        [theScanner setScanLocation: newLoc];
        
        // find end of tag - look for closing quote
        [theScanner scanUpToString: @"""" intoString: &text];
    }
    //NSLog(@"appUrlString = %@", text);
    return text;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        
        // this has to be a new custom array to contain the link that is passed to the detail view
        
        if([_revisedArray count] > 0)
        {
            Tweet *tweetItem = [_revisedArray objectAtIndex:row];
            
            // NSLog (@"Number of elements in revised array = %u", [_revisedArray count]);
            
            TweetTextViewController *detailController = segue.destinationViewController;
            
            if(tweetItem !=nil)
            {
                detailController.detailItem = tweetItem.appURLString;
            }
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

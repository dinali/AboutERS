/*
     File: DetailViewController.m
 Abstract: Creates a grouped table view to act as an inspector.
  Version: 3.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import "DetailViewController.h"
//#import "Play.h"
#import "Publication.h"
// TODO: implement this #import "PublicationCellView.h"


@implementation DetailViewController

@synthesize publication;


#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    // Update the view with current data before it is displayed.
    [super viewWillAppear:animated];
    
    // Scroll the table view to the top before it appears
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:NO];
   // self.title = play.title;
    self.title = publication.titleName;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // There are sections for title, short description, long description, pdf, and keywords
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	/*
	 The number of rows varies by section.
	 */
   /* NSInteger rows = 0;
    switch (section) {
        case 0:
        case 1:
            // For genre and date there is just one row.
            rows = 1;
            break;
        case 2:
            // For the characters section, there are as many rows as there are characters.
            rows = [play.characters count];
            break;
        default:
            break;
    }
    return rows;
    */
    
    return 1;
}

/* tried to include a custom tableview cell PublicationCellView but it crashed */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // static NSString *cellIdentifier = @"PublicationCell";
   // static NSString *cellIdentifier = @"PublicationCell";

    // custom cell
    /*PublicationCellView *cell = (PublicationCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        cell = [[PublicationCellView alloc] init];
    }
     */
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    
    NSString *cellText = nil;
    NSString *detailText = nil;
    
    switch (indexPath.section) {
        case 0:
            cellText = publication.titleName;
            detailText = publication.author;
            break;
        case 1:
            cellText = publication.shortDescription;
            detailText = publication.pubDate;
            break;
        case 2:
            cellText = publication.longDescription;
            break;
        case 3:
            cellText = publication.pdfURL;
            break;
        case 4:
            cellText = publication.keywords;
            break;
        default:
            break;
    }
    
    
    cell.textLabel.text = cellText;
    cell.detailTextLabel.text = detailText;
    
   // cell.contentTextView.text = cellText;
    return cell;
}


#pragma mark -
#pragma mark Section header titles

/*
 HIG note: In this case, since the content of each section is obvious, there's probably no need to provide a title, but the code is useful for illustration.
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    switch (section) {
        case 0:
            title = NSLocalizedString(@"Title", @"title section title");
            break;
        case 1:
            title = NSLocalizedString(@"Description", @"description section title");
            break;
        case 2:
            title = NSLocalizedString(@"Summary", @"summary section title");
            break;
        case 3:
            title = NSLocalizedString(@"Full Report (PDF)", @"full report section title");
            break;
        case 4:
            title = NSLocalizedString(@"Keywords", @"keywords section title");
            break;
        default:
            break;
    }
    return title;
}


@end

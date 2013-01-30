//
//  apiViewController.m
//  WSsample
//
//  Created by Dina Li on 1/22/13.
//
//

#import "apiViewController.h"

@interface apiViewController ()

@end

@implementation apiViewController

/*@synthesize titleLabel = _titleLabel;         // title
@synthesize contentLabel = _dateLabel;   // description
@synthesize contentTextView = ;
//@synthesize releaseDateLabel = _releaseDateLabel;
@synthesize chartImageView = _imageView;  // display the chart in the imageview
*/

@synthesize titleLabel = _titleLabel;
@synthesize dateLabel = _dateLabel;
@synthesize imageView = _imageView;
@synthesize descriptionTextView = _descriptionTextView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear{
    //self.title = @"Retrieve Data From Website API";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Charts of Note";
    
    dispatch_queue_t kBgQueue = dispatch_get_global_queue(
                                                          DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //NSURL *url = [NSURL URLWithString:
    //                     @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"]; //2
    
   // NSURL *url = [NSURL URLWithString:@"http://api.ers.usda.gov/REST/v1/charts/all"];
    NSURL *url = [NSURL URLWithString:@"http://api.ers.usda.gov/REST/v1/charts/mostrecent/3/"];
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        url];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

// Description:
// there is a top level array of dictionaries with the create date and release date
// each item in the array represents one Chart of Note (or whatever)
// below that, there is a Properties Array: index[1] contains the title, index[0] contains the image URL, index[8] contains the description
// need the title, url, release date, and description

- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    
    NSArray* jsonArray = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    
    //    for (key in json) WORKS IF ITS A DICTIONARY
    //    {
    //        value = [json objectForKey: key];
    //           NSLog(@"json dictionary value = %@", value); // value is NULL
    //           NSLog(@"json dictionary key = %@", key);
    //        j++;
    //
    //    }
    //    NSInteger j = 0;
    NSUInteger i = 0;
    NSUInteger records = [jsonArray count];
    NSString *item, *title, *url, *releaseDate, *description, *chartID = nil;
    
    // TODO: change UI, this displays only the first ChartOfNote
    NSDictionary* jsonDictionary = [jsonArray objectAtIndex:0];
    NSArray *propertiesArray;
    
    //    key = @"Title";
    //    url = @"Url";
    //    releaseDate = @"ReleaseDate";
    
    @try {
        
        // array of dictionaries within the big json array
        for (i = 0; i < records; i++)
        {
      //       NSLog (@"Element %i = %@", i, [jsonArray objectAtIndex: i]); // print out ALL the Chart info
            
            if ([[jsonArray objectAtIndex:i] isKindOfClass:[NSDictionary class]])
            {
                //for (NSDictionary *jsonDictionary in jsonArray)
                for (item in jsonDictionary)
                {
                    title = [jsonDictionary objectForKey: @"Title"];
                    url = [jsonDictionary objectForKey: @"Url"];
                    releaseDate = [jsonDictionary objectForKey: @"ReleaseDate"];
                    chartID = [jsonDictionary objectForKey:@"Id"];
                    
                    if([item isEqualToString:@"Properties"])
                    {
                        propertiesArray = [jsonDictionary objectForKey:@"Properties"];
                        
                        if(propertiesArray.count > 0) // get the sub-dictionary that contains the description
                        {
                            // loop thru the Array and find the dictionary with the description keyField
                            NSUInteger g = 0;
                            
                            for(g =0; g<propertiesArray.count; g++)
                            {
                                NSDictionary *descriptionDictionary = [propertiesArray objectAtIndex:g]; // can't hard code because the structure changes!!
                                /*
                                id key = nil;
                                NSString *value = nil;
                                                            
                                for (key in descriptionDictionary) // what's inside?
                                {
                                    value = [descriptionDictionary objectForKey: key];
                                       NSLog(@"json dictionary value = %@", value); 
                                       NSLog(@"json dictionary key = %@", key);
                                }
                            */
                            // ALERT: !! strange format: keyfield:description; propertyValueField: the text description
                            if([[descriptionDictionary objectForKey:@"keyField"] isEqualToString:@"description"])
                                {
                                    description = [descriptionDictionary objectForKey:@"propertyValueField"];
                                    NSLog(@"description = %@", description);
                                }
                            } // end for g
                        }
                    }
                }
            }
        } // end for
    }
    @catch (NSException *exception) {
        NSLog(@"error loading objects %@", exception);
    }
    @finally {
        // how to terminate here?
    }
    
    //////////////////////////////////
    /* display variables on UIView */
    /////////////////////////////////
    
    _titleLabel.text = title;
    _dateLabel.text = [self formatDate:releaseDate]; // get formatted date
    _descriptionTextView.text = description;
    _imageView.image = [self loadImage:url];
  //  NSLog(@"id = %@", chartID);
    
    
    /* EXAMPLE: return a dictionary element from a dictionary element */
//     contentLabel.text = [NSString stringWithFormat:@"Latest loan: %@
//     from %@ needs another $%.2f to pursue their entrepreneural dream",
//     [loan objectForKey:@"name"],
//     [(NSDictionary*)[loan objectForKey:@"location"]
//     objectForKey:@"country"],
//     outstandingAmount];
    }
//
#pragma mark - date formatter
/* incoming date is the one that needs formatting */
- (NSString*) formatDate:(NSString*)unformattedDateString
{
    NSString *outputDateString = nil;
    
    if(unformattedDateString !=nil)
    {
        NSString *dateString = unformattedDateString;
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateStyle:NSDateFormatterMediumStyle];
        [outputFormatter setTimeStyle:NSDateFormatterNoStyle];
        
        NSDate *date = [inputFormatter dateFromString:dateString];
        
        //this will set date's time components to 00:00
        [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                        startDate:&date
                                         interval:NULL
                                          forDate:date];
        
        outputDateString = [outputFormatter stringFromDate:date];
    }
    else
    {
        NSLog(@"incoming date was nil");
    }
    return outputDateString;
}

#pragma mark - retrieve image
/* TODO: this should be done on a background thread in case the image is slow or bombs */
- (UIImage*) loadImage:(NSString*)urlForImageString
{
    NSData * imageData = nil;
    UIImage * image = nil;
    
    NSString *urlPath = @"http://www.ers.usda.gov";
    
    NSMutableString *fullURL;
    
    if (fullURL == nil){
        fullURL = [[NSMutableString alloc] init];
    }
    
    [ fullURL appendString: urlPath];
    [ fullURL appendString: urlForImageString];
    
    NSURL *imageURL = [NSURL URLWithString:fullURL];
    
    @try {
        imageData = [NSData dataWithContentsOfURL:imageURL];
        image = [UIImage imageWithData:imageData];
    }
    @catch (NSException *exception) {
        NSLog(@"crashed loading the image = %@", exception);
    }
    @finally {
        //<#statements#>
    }
    
    return image;
}

- (void)viewDidUnload
{
    [self setDescriptionTextView:nil];
    [self setTitleLabel:nil];
    [self setImageView:nil];
    [self setDateLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


/*
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
 return 0;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *CellIdentifier = @"Cell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
// Navigation logic may go here. Create and push another view controller.
/*
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
 // ...
 // Pass the selected object to the new view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 */
//}

#pragma mark - OLD CODE for Properties Array

/*
 
 TODO: get the Description out of the Properties Array
 
 NSArray* propertiesArray = [json objectForKey:@"Properties"];
 NSInteger index = 0;
 
 for(id element in propertiesArray) {
 NSLog(@"element at index %u is = %@", index, element);
 index++;
 }
 
 // a chart's properties are stored in the array
 NSDictionary* chart = [propertiesArray objectAtIndex:0];
 NSString *item = nil;  // contain the value associated with the key
 NSInteger *g = 0;
 //  NSDictionary *subElementDict = [[NSDictionary alloc] init];
 NSString *file = @"file";
 NSString *title = @"title";
 
 for (item in chart)
 {
 value = [chart objectForKey:file];  // path to the image
 
 if( [value isKindOfClass:[NSString class]])
 {
 NSLog(@"chart value = %@", value);
 NSLog(@"chart key = %@", item);
 g++;
 }
 
 value = [chart objectForKey:title];  // title
 
 if( [value isKindOfClass:[NSString class]])
 {
 NSLog(@"chart value = %@", value);
 NSLog(@"chart key = %@", item);
 g++;
 }
 
 
 else {      // dictionary of more info
 subElementDict = [loan objectForKey:@"source"];
 NSString *leafString = [subElementDict objectForKey:@"licenseType"];
 
 NSLog(@"leaf value = %@", leafString );
 NSLog(@"loan key = %@", item);
 g++;
 }
 */

#pragma mark - OLD CODE for label formatting, might not be needed in iOS6?
// titleLabel.text = [subElementDict objectForKey:@"licenseType"];
/*
 _dateLabel.numberOfLines = 8;
 _dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
 CGSize textSize = [self.contentLabel.text sizeWithFont:self.contentLabel.font
 constrainedToSize:CGSizeMake(self.contentLabel.frame.size.width, MAXFLOAT)
 lineBreakMode:self.contentLabel.lineBreakMode];
 _dateLabel.frame = CGRectMake(5.0f, 5.0f, (textSize.width + 20), (textSize.height + 20));
 
 _titleLabel.numberOfLines = 8;
 _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
 
 CGSize textSize2 = [self.contentLabel.text sizeWithFont:self.titleLabel.font
 constrainedToSize:CGSizeMake(self.contentLabel.frame.size.width, MAXFLOAT)
 lineBreakMode:self.titleLabel.lineBreakMode];
 _dateLabel.frame = CGRectMake(0.0f, 0.0f, textSize2.width, (textSize2.height + 20));
 */

@end

//
//  Parser.m
//  ParseERSfeed
//
//  Created by Dina Li on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//
//  Parser.m
//  Parse2
//
//  Created by Dina Li on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Parser.h"
#import "Record.h"
#import "Title.h"

@implementation Parser

@synthesize recordsArray = _recordsArray;

NSMutableString	*currentNodeContent;
NSXMLParser		*parser;
Record			*currentRecord;
Title              *titleText;
bool            isStatus;
NSMutableString *workingPropertyString;

// element names
static NSString *kEntryStr = @"item"; // this is the top element
static NSString *kTitleStr = @"title";
static NSString *kDescriptionStr = @"description";
static NSString *kLinkStr = @"link";

-(id) loadXMLByURL:(NSString *)urlString
{
	_recordsArray	= [[NSMutableArray alloc] init];
	NSURL *url		= [NSURL URLWithString:urlString];
	NSData	*data   = [[NSData alloc] initWithContentsOfURL:url];
	parser			= [[NSXMLParser alloc] initWithData:data];
	parser.delegate = self;
    
    @try {
        [parser parse];
    }
    @catch (NSException *exception) {
        NSLog(@"exception %@", exception);
    }
    @finally {
    }
	return self;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //NSLog(@"foundCharacters: currentNodeContent %@", currentNodeContent);
}

/*
 <rss xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:wfw="http://wellformedweb.org/CommentAPI/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rssdatehelper="urn:rssdatehelper" version="2.0">
 <channel>
 <title>Food & Nutrition Assistance</title>
 <link>http://ers.usda.gov</link>
 <pubDate>Mon, 01 Jan 0001 00:00:00 GMT</pubDate>
 <generator>umbraco</generator>
 <description>
 Child nutrition programs, food and nutrition assistance research, food security in the U.S., poverty and income volatility, Supplemental Nutrition Assistance Program (SNAP), and WIC Program.
 </description>
 <language>en-us</language>
 <item>
 <title>
 How Economic Conditions Affect Participation in USDA Nutrition Assistance Programs
 </title>
 <link>
 http://ers.usda.gov/publications/eib-economic-information-bulletin/eib100.aspx
 </link>
 <pubDate>Fri, 21 Sep 2012 16:00:00 GMT</pubDate>
 <guid>
 http://ers.usda.gov/publications/eib-economic-information-bulletin/eib100.aspx
 </guid>
 <description>
 <p>This study, based on 1976-2010 data, examines the relationship between U.S. economic conditions and participation in the U.S. Department of Agriculture's five largest nutrition assistance programs.</p>
 </description>
 </item>
 
 */
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // skip the first few elements
    if ([elementName isEqualToString:kEntryStr]) // item
    {
        currentRecord = [[Record alloc] init];
        isStatus = YES;
       // NSLog(@"item");
    }
    /*
    if ([elementName isEqualToString:kTitleStr])
    {
        //currentRecord.titleString = currentNodeContent;
       // NSLog(@"start Title %@", currentNodeContent);
    }
    if ([elementName isEqualToString:kLinkStr])
    {
        // currentRecord.linkString = currentNodeContent;
       // NSLog(@"start link %@", currentNodeContent);
    }
    if ([elementName isEqualToString:kDescriptionStr])
    {
        //currentRecord.descriptionString = currentNodeContent;
       // NSLog(@"start description %@", currentNodeContent);
    }
    if([elementName isEqualToString:@"p"]) // nested in description
    {
        // currentRecord.descriptionString = currentNodeContent;
        // NSLog(@"start p = %@", currentNodeContent);
    }
     */
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (isStatus)
    {
        // [currentNodeContent setString:@""];  // clear the string for next time
        
        if ([elementName isEqualToString:kTitleStr])
        {
            currentRecord.titleString = currentNodeContent;
            //NSLog(@"end Title %@", currentNodeContent);
        }
        else if ([elementName isEqualToString:kLinkStr])
        {
            currentRecord.linkString = currentNodeContent;
            //NSLog(@"endlink %@", currentNodeContent);
        }
        else if ([elementName isEqualToString:kDescriptionStr])
        {
            // NSLog(@"found end description");
            currentRecord.descriptionString = currentNodeContent;
          //  NSLog(@"end p = %@", currentNodeContent);
            
            if([elementName isEqualToString:@"p"])
            {
                currentRecord.descriptionString = currentNodeContent;
               // NSLog(@"end p = %@", currentNodeContent);
            }
        }
        else if([elementName isEqualToString:@"p"])
        {
            currentRecord.descriptionString = currentNodeContent;
            //NSLog(@"end p = %@", currentNodeContent);
        }
        // item is the top level element
        else if ([elementName isEqualToString:kEntryStr])
        {
            [self.recordsArray addObject:currentRecord];
            currentRecord = nil;
           // NSLog(@"added the object");
        }
    } // end if status
}

@end




//
//  CandyTableViewController.m
//  CandySearch
//
//  Created by Nicolas Martin on 7/5/12.
//  Copyright (c) 2012 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "CandyTableViewController.h"
//#import "Candy.h"
#import "DataController.h"
#import "DetailViewController.h"
//#import "Play.h"
#import "Publication.h"


@interface CandyTableViewController ()

@end

@implementation CandyTableViewController
@synthesize candyArray;
@synthesize filteredCandyArray;
@synthesize candySearchBar;

@synthesize dataController;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = NSLocalizedString(@"Publications", @"Master view navigation title");

    [super viewDidLoad];
    
    // Don't show the scope bar or cancel button until editing begins
    [candySearchBar setShowsScopeBar:NO];
    [candySearchBar sizeToFit];
    
    // Hide the search bar until user scrolls up
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + candySearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];

    /*** Sample Data for candyArray EPIC FAILURE TO MODIFY METHOD ***/
    // REPLACED with DataController for Publications
    // create objects separately
    /*
    Candy *testCandy = [[Candy alloc] init];
    testCandy.category = @"(Farm Economy)";
    testCandy.name = @"Paul Westcott ";
    testCandy.phone = @"202-694-5335  ";
    testCandy.email = @"westcott@ers.usda.gov";
    
    Candy *testCandy2 = [[Candy alloc] init];
    testCandy2.category = @"(Crops)";
    testCandy2.name = @"Edward Allen ";
    testCandy2.phone = @"202-694-8888  ";
    testCandy2.email = @"allen@ers.usda.gov";
    
    Candy *testCandy3 = [[Candy alloc] init];
    testCandy3.category = @"(Animal Products)";
    testCandy3.name = @"Kenneth Matthews ";
    testCandy3.phone = @"202-694-9999  ";
    testCandy3.email = @"matthews@ers.usda.gov";
    
    candyArray = [NSArray arrayWithObjects: testCandy,
                  testCandy2,
                  testCandy3, nil];
  */  
 //   NSLog(@"test candy category = %@", testCandy.category);
 //   NSLog(@"test candy name = %@", testCandy.name);
 //   NSLog(@"test candy phone = %@", testCandy.phone);
    
    
    // fill the candyArray with the publications from the DataController
    candyArray = [NSArray arrayWithArray:dataController.list];
    
    
    filteredCandyArray = [NSMutableArray arrayWithCapacity:[dataController countOfList]];
    
   // filteredCandyArray = [NSMutableArray arrayWithCapacity:[candyArray count]];

    // Reload the table
    [[self tableView] reloadData];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Only one section.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // different from SimpleDrillDown code - return [dataController countOfList];
    
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredCandyArray count];
    }
	else
	{
        return [candyArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Create a new Candy Object
   // Candy *candy = nil;
    Publication *publication = nil;
    
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        publication = [filteredCandyArray objectAtIndex:[indexPath row]];
    }
	else
	{
        publication = [candyArray objectAtIndex:[indexPath row]];
    }
    
    // Configure the cell
    
    // add the phone + email and display together
    // NSString *newString = [aString stringByAppendingString:anotherString];
    
    /*
    NSString *details = [[candy phone] stringByAppendingString: [candy email]];
    NSString *nameAndCategory = [[candy name] stringByAppendingString: [candy category]];
    
    [[cell textLabel] setText:nameAndCategory];
    [[cell detailTextLabel] setText:details];
     */
    
 //   [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
     // Get the object to display and set the value in the cell.
     Publication *publicationAtIndex = [dataController objectInListAtIndex:indexPath.row];
     cell.textLabel.text = publicationAtIndex.titleName;
    
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Perform segue to candy detail
    [self performSegueWithIdentifier:@"publicationDetail" sender:tableView];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // have to modify the CandyTableViewController to be like the RootView so that the detailsviewcontroller is used
    
    // this is the RootViewController code
    
    if ( [[segue identifier] isEqualToString:@"publicationDetail"] ) {

        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.publication = [dataController objectInListAtIndex:selectedRowIndex.row];
    }
    
    // ORIGINAL CandySearch
    
   /* if ( [[segue identifier] isEqualToString:@"publicationDetail"] ) {
        UIViewController *candyDetailViewController = [segue destinationViewController];
        
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            NSString *destinationTitle = [[filteredCandyArray objectAtIndex:[indexPath row]] name];
            [candyDetailViewController setTitle:destinationTitle];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSString *destinationTitle = [[candyArray objectAtIndex:[indexPath row]] name];
            [candyDetailViewController setTitle:destinationTitle];
        }
        
    }
    */
    
    
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredCandyArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.titleName contains[c] %@",searchText];
    NSArray *tempArray = [candyArray filteredArrayUsingPredicate:predicate];
    
    
    /* DISABLE FOR NOW - this is the scope filtering
    if(![scope isEqualToString:@"All"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@",scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
     */
    
    filteredCandyArray = [NSMutableArray arrayWithArray:tempArray];
}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Search Button

- (IBAction)goToSearch:(id)sender
{
    // If you're worried that your users might not catch on to the fact that a search bar is available if they scroll to reveal it, a search icon will help them
    // Note that if you didn't hide your search bar, you should probably not include this, as it would be redundant
    [candySearchBar becomeFirstResponder];
}



















@end

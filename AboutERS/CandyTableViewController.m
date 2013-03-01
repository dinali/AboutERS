//
//  CandyTableViewController.m
//  CandySearch
//
//  Created by Nicolas Martin on 7/5/12.
//  Copyright (c) 2012 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "CandyTableViewController.h"
#import "Candy.h"

@interface CandyTableViewController ()

@end

@implementation CandyTableViewController
@synthesize candyArray;
@synthesize filteredCandyArray;
@synthesize candySearchBar;

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
    
    // Don't show the scope bar or cancel button until editing begins
    [candySearchBar setShowsScopeBar:NO];
    [candySearchBar sizeToFit];
    
    // Hide the search bar until user scrolls up
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + candySearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];

    /*** Sample Data for candyArray EPIC FAILURE TO MODIFY METHOD ***/
    
    // create objects separately
    
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
    
    Candy *testCandy8 = [[Candy alloc] init];
    testCandy8.category = @"(Food and Nuitrition Assistance)";
    testCandy8.name = @"Joanne Guthrie ";
    testCandy8.phone = @"202-694-9999  ";
    testCandy8.email = @"guthrie@ers.usda.gov";
    
    Candy *testCandy4 = [[Candy alloc] init];
    testCandy4.category = @"(Food and Nuitrition Assistance)";
    testCandy4.name = @"Victor Oliveira ";
    testCandy4.phone = @"202-694-9999  ";
    testCandy4.email = @"oliveira@ers.usda.gov";
    
    Candy *testCandy5 = [[Candy alloc] init];
    testCandy5.category = @"(Food Choices & Health)";
    testCandy5.name = @"Bin-Hwan Lin ";
    testCandy5.phone = @"202-694-9999  ";
    testCandy5.email = @"lin@ers.usda.gov";
    
    Candy *testCandy6 = [[Candy alloc] init];
    testCandy6.category = @"(Food Products & Prices)";
    testCandy6.name = @"Ricky Volpe ";
    testCandy6.phone = @"202-694-9999  ";
    testCandy6.email = @"volpe@ers.usda.gov";
    
    Candy *testCandy7 = [[Candy alloc] init];
    testCandy7.category = @"(International Markets And Trade)";
    testCandy7.name = @"Fred Gale ";
    testCandy7.phone = @"202-694-9999  ";
    testCandy7.email = @"gale@ers.usda.gov";
    
    candyArray = [NSArray arrayWithObjects: testCandy,
                  testCandy2,
                  testCandy3,
                  testCandy4,
                  testCandy5,
                  testCandy6,
                  testCandy8,
                  testCandy7,
                  nil];
    
    // Initialize the filteredCandyArray with a capacity equal to the candyArray's capacity
    
    filteredCandyArray = [NSMutableArray arrayWithCapacity:[candyArray count]];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    Candy *candy = nil;
    
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        candy = [filteredCandyArray objectAtIndex:[indexPath row]];
    }
	else
	{
        candy = [candyArray objectAtIndex:[indexPath row]];
    }
    
    // Configure the cell
    
    // add the phone + email and display together
    // NSString *newString = [aString stringByAppendingString:anotherString];
    NSString *details = [[candy phone] stringByAppendingString: [candy email]];
    NSString *nameAndCategory = [[candy name] stringByAppendingString: [candy category]];
    
    [[cell textLabel] setText:nameAndCategory];
    [[cell detailTextLabel] setText:details];
 //   [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Perform segue to candy detail
    [self performSegueWithIdentifier:@"specialistDetail" sender:tableView];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"specialistDetail"] ) {
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
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredCandyArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    NSArray *tempArray = [candyArray filteredArrayUsingPredicate:predicate];
    
    if(![scope isEqualToString:@"All"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@",scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    
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

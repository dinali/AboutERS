//
//  CandyTableViewController.m
//  CandySearch
//
//  Created by Nicolas Martin on 7/5/12.
//  Copyright (c) 2012 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "SubjectSpecialistViewController.h"
#import "DataController.h"
#import "DetailViewController.h"
#import "Publication.h"

@interface SubjectSpecialistViewController ()

@end

@implementation SubjectSpecialistViewController

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
    
    // fill the candyArray with the publications from the DataController
    
    dataController = [[DataController alloc]init];
    
    candyArray = [NSArray arrayWithArray:dataController.list];
    
    filteredCandyArray = [NSMutableArray arrayWithCapacity:[dataController countOfList]];
    
    // Reload the table
    [[self tableView] reloadData];
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
    
   [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    cell.textLabel.text = publication.titleName;

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
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredCandyArray removeAllObjects];
    
	// Filter the array using NSPredicate - FIX THIS
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

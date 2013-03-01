//
//  CandyTableViewController.h
//  CandySearch
//  http://www.raywenderlich.com/16873/how-to-add-search-into-a-table-view
//  Created by Nicolas Martin on 7/5/12.
//  Copyright (c) 2012 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataController;

@interface CandyTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong,nonatomic) NSArray *candyArray;
@property (strong,nonatomic) NSMutableArray *filteredCandyArray;
@property IBOutlet UISearchBar *candySearchBar;
@property (nonatomic, strong) DataController *dataController;



@end

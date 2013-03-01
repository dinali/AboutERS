//
//  ERSAppDelegate.m
//  AboutERS
//  Modified March 1, 2013 to include the Publications Specialist Search Feature
//  Created by Dina Li on 1/29/13.
//  Copyright (c) 2013 ers. All rights reserved.
//

#import "ERSAppDelegate.h"
#import "CandyTableViewController.h"
#import "DataController.h"

@interface ERSAppDelegate ()

@property (nonatomic, strong) CandyTableViewController *rootViewController;
@property (nonatomic, strong) DataController *dataController;

@end

@implementation ERSAppDelegate

@synthesize window=_window, rootViewController=_rootViewController, dataController = _dataController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Create the data controller and pass it to the root view controller.
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    
    CandyTableViewController *rootViewController = (CandyTableViewController *)[[navigationController viewControllers]objectAtIndex:0];
    
    _dataController = [[DataController alloc] init];
    rootViewController.dataController = _dataController;
    self.dataController = _dataController;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

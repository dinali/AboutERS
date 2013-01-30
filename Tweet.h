//
//  Tweet.h
//  Tabs
//
//  Created by Dina Li on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
{
    UIImage *icon;       // this is the icon version for the initial view
    NSString *title;
    NSString *imageURLString;
    NSString *subtitle;
    NSString *appURLString;
    NSString *summary;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property(nonatomic,strong) NSString *imageURLString;
@property (nonatomic, strong) UIImage *icon;
@property(nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *appURLString;
//@property (nonatomic, retain) NSString *appName;
//@property(nonatomic,retain)UIImage *appFullChart;


@end

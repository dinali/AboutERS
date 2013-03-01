//
//  Candy.h
//  CandySearch
//
//  Created by Nicolas Martin on 7/5/12.
//  Copyright (c) 2012 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Candy : NSObject {
   // NSString *category;
   // NSString *name;
   // NSString *phone;
}

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;

// not used
//+ (id)candyOfCategory:(NSString*)category name:(NSString*)name phone:(NSString*)phone;

@end

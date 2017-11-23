//
//  LoginItemUtility.h
//  CDN Fetch
//
//  Created by Charles Kenney on 10/23/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

#ifndef LoginItemUtility_h
#define LoginItemUtility_h

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface LoginItemUtility: NSObject

+ (void)addToLoginItems;
+ (void)deleteFromLoginItems;
+ (BOOL)isLoginItem;

@end

#endif /* LoginItemUtility_h */

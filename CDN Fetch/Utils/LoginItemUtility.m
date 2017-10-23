//
//  LoginItemUtility.m
//  CDN Fetch
//
//  Created by Charles Kenney on 10/23/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

#import "LoginItemUtility.h"

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@implementation LoginItemUtility

/**
 * Use LSSharedFileListRef is depreciated in favor of the
 * System Management framework, however LSSharedFileRef allows
 * the user to manage the login item in settings, without the
 * app. This is most preferable as it is more accessable to the user.
 */

// adds to shared login items
+ (void)addToLoginItems {
    LSSharedFileListRef list = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSURL *bundleUrl = [NSURL fileURLWithPath:bundlePath];
    
    if (list) {
        LSSharedFileListItemRef listItem = LSSharedFileListInsertItemURL(list, kLSSharedFileListItemLast, NULL, NULL, (__bridge CFURLRef)bundleUrl, NULL, NULL);
        if (listItem) {
            CFRelease(listItem);
        }
        CFRelease(list);
        NSLog(@"Successfully added login item");
    } else {
        NSLog(@"Error adding login item");
    }
}

// deletes from shared login items
+ (void)deleteFromLoginItems {
    LSSharedFileListRef list = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    
    if (list) {
        UInt32 val;
        NSArray *listArray = CFBridgingRelease(LSSharedFileListCopySnapshot(list, &val));
        
        for (id file in listArray) {
            LSSharedFileListItemRef fileRef = (__bridge LSSharedFileListItemRef)file;
            CFURLRef bundleUrl = LSSharedFileListItemCopyResolvedURL(fileRef, 0, NULL);
            
            if (bundleUrl) {
                NSString *resolved = [(__bridge NSURL*)bundleUrl path];
                
                if ([resolved compare:bundlePath] == NSOrderedSame) {
                    LSSharedFileListItemRemove(list, fileRef);
                }
            }
        }
    }
}

@end

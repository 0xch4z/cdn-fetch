//
//  LoginItemUtility.m
//  CDN Fetch
//
//  Created by Charles Kenney on 10/23/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

#import "LoginItemUtility.h"

@implementation LoginItemUtility

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

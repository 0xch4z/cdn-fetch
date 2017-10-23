//
//  AppDelegate.m
//  CDN Fetch Helper
//
//  Created by Charles Kenney on 10/22/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSArray *pathComponents = [[[NSBundle mainBundle] bundlePath] pathComponents];
    pathComponents = [pathComponents subarrayWithRange:NSMakeRange(0, [pathComponents count] - 4)];
    NSString *path = [NSString pathWithComponents:pathComponents];
    NSLog(@"path %@", path);
    [[NSWorkspace sharedWorkspace] launchApplication:path];
    [self alert];
//    [NSApp terminate:nil];
}


- (void)alert {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"The helper has started!"];
    [alert setInformativeText:@"Just to let you know! (:"];
    [alert addButtonWithTitle:@"thanks!"];
    [alert runModal];
    
}

- (void)sayThanksAndTerminate {
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}


@end

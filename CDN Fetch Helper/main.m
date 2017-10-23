//
//  main.m
//  CDN Fetch Helper
//
//  Created by Charles Kenney on 10/22/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    NSLog(@"Starting auto launch helper");
    NSApplication *application = [NSApplication sharedApplication];
    AppDelegate *delegate = [[AppDelegate alloc] init];
    NSString *foo = [[NSBundle mainBundle] bundleIdentifier];
    NSLog(@"identifier: %@", foo);
    [application setDelegate:delegate];
    [application run];
    return 0;
}

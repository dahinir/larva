//
//  larvaAppDelegate.m
//  larva
//
//  Created by Daehyeon Shin on 2/10/10.
//  Copyright dasolute 2010. All rights reserved.
//

#import "larvaAppDelegate.h"

@implementation larvaAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end

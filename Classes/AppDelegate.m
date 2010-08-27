//
//  AppDelegate.m
//  larva
//
//  Created by Daehyeon Shin on 4/24/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

@synthesize window, viewController;

-(void)applicationDidFinishLaunching:(UIApplication*)application
{
	NSLog(@"application did finish launching");
	// Add the view controller's view to the window
	[window addSubview:viewController.view];
	[window makeKeyAndVisible];
	NSLog(@"added sub view");
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	NSLog(@"hey got a memory warning!");
}

-(void)applicationWillResignActive:(UIApplication *)application {
	NSLog(@"hey I'm about to resign active status..");
}

-(void)applicationDidBecomeActive:(UIApplication *)application {
	NSLog(@"welcome back!");
}

// Release resoures
-(void)dealloc
{
	[window release];
	[viewController release];
	[super dealloc];
}

@end

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
	// Add the view controller's view to the window
	[window addSubview:viewController.view];
}

// Release resoures
-(void)dealloc
{
	[window release];
	[viewController release];
	[super dealloc];
}

@end

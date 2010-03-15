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

@synthesize acc_x;
@synthesize acc_y;
@synthesize acc_z;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}

// accelerometer configure
-(void)configureAccelerometer {
    UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
    theAccelerometer.updateInterval = 1 / 50;
    theAccelerometer.delegate = self;
    // Delegate events begin immediately.
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	UIAccelerationValue x,y,z;
	x = acceleration.x;
	y = acceleration.y;
	z = acceleration.z;
	
	[acc_x setText:[NSString stringWithFormat:@"%.4f", acceleration.x]];
	[acc_y setText:[NSString stringWithFormat:@"%.4f", acceleration.y]];
	[acc_z setText:[NSString stringWithFormat:@"%.4f", acceleration.z]];
}

- (IBAction) button01pressed:(id)sender {
	acc_x.text= @"haha";
	[self configureAccelerometer];
}

- (IBAction) button02pressed:(id)sender {
}

@end

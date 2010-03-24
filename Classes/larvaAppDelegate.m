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

@synthesize distance_x, distance_y, distance_z;
@synthesize speed_x, speed_y, speed_z;
@synthesize acc_x, acc_y, acc_z;


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
    theAccelerometer.updateInterval = 1 / 50;	// as 20 millisecond, 100 is max (10 milliseconds)
    theAccelerometer.delegate = self;
    // Delegate events begin immediately.
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	UIAccelerationValue x,y,z;
	
	x = acceleration.x;
	y = acceleration.y;
	z = acceleration.z;
	[acc_x setText:[NSString stringWithFormat:@"%.4f", x]];
	[acc_y setText:[NSString stringWithFormat:@"%.4f", y]];
	[acc_z setText:[NSString stringWithFormat:@"%.4f", z]];
	
	speedX = speedX + x*0.2;
	speedY = speedY + y*0.2;
	speedZ = speedZ + z*0.2;
	[speed_x setText:[NSString stringWithFormat:@"%.4f", speedX ]];
	[speed_y setText:[NSString stringWithFormat:@"%.4f", speedY ]];
	[speed_z setText:[NSString stringWithFormat:@"%.4f", speedZ ]];
	
	distanceX = distanceX + speedX*0.2;
	distanceY = distanceY + speedY*0.2;
	distanceZ = distanceZ + speedZ*0.2;
	[distance_x setText:[NSString stringWithFormat:@"%.4f", distanceX ]];
	[distance_y setText:[NSString stringWithFormat:@"%.4f", distanceY ]];
	[distance_z setText:[NSString stringWithFormat:@"%.4f", distanceZ ]];
}

- (IBAction) button01pressed:(id)sender {
	acc_x.text= @"haha";
	speedX,speedY, speedZ = 0;
	distanceX, distanceY, distanceZ = 0;
	[self configureAccelerometer];
}

- (IBAction) button02pressed:(id)sender {
}

@end

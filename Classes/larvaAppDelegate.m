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

/* accelerometer */
@synthesize distance_x, distance_y, distance_z;
@synthesize speed_x, speed_y, speed_z;
@synthesize acc_x, acc_y, acc_z;
#define kFilteringFactor 0.1

/* teslameter */
@synthesize magnitudeLabel;
@synthesize xLabel;
@synthesize yLabel;
@synthesize zLabel;
@synthesize locationManager;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}

- (void)dealloc {
	
	/* teslameter */
	[magnitudeLabel release];
	[xLabel release];
	[yLabel release];
	[zLabel release];
	// Stop the compass
	[locationManager stopUpdatingHeading];
    [locationManager release];
	
	/* default */
    [window release];
    [super dealloc];
}

/* accelerometer */
// accelerometer configure
-(void)configureAccelerometer {
    UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
    theAccelerometer.updateInterval = kFilteringFactor;	// as 10 millisecond, 100 is max (10 milliseconds)
    theAccelerometer.delegate = self;
    // Delegate events begin immediately.
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	/*
	UIAccelerationValue accelX, accelY, accelZ;
	accelX = acceleration.x;
	accelY = acceleration.y;
	accelZ = acceleration.z;
	 */
	/* Use a basic low-pass filter to keep only the gravity component of each axis.
    accelX = (acceleration.x * kFilteringFactor) + (accelX * (1.0 - kFilteringFactor));
	// temp = accelX*100;
	// accelX = temp/100;
    accelY = (acceleration.y * kFilteringFactor) + (accelY * (1.0 - kFilteringFactor));
    accelZ = (acceleration.z * kFilteringFactor) + (accelZ * (1.0 - kFilteringFactor));
	 */
	// 이전값과 차이값을 일정이상만(쓰레솔더)
	// 하이패스 필터와 중력 필터는 다르다.
	accelX = acceleration.x - ( (acceleration.x * kFilteringFactor) + (accelX * (1.0 - kFilteringFactor)) );
    accelY = acceleration.y - ( (acceleration.y * kFilteringFactor) + (accelY * (1.0 - kFilteringFactor)) );
    accelZ = acceleration.z - ( (acceleration.z * kFilteringFactor) + (accelZ * (1.0 - kFilteringFactor)) );
	[acc_x setText:[NSString stringWithFormat:@"%.4f", accelX ]];
	[acc_y setText:[NSString stringWithFormat:@"%.4f", accelY ]];
	[acc_z setText:[NSString stringWithFormat:@"%.4f", accelZ ]];
	
	speedX = speedX + accelX*kFilteringFactor;
	speedY = speedY + accelY*kFilteringFactor;
	speedZ = speedZ + accelZ*kFilteringFactor;
	[speed_x setText:[NSString stringWithFormat:@"%.4f", speedX ]];
	[speed_y setText:[NSString stringWithFormat:@"%.4f", speedY ]];
	[speed_z setText:[NSString stringWithFormat:@"%.4f", speedZ ]];
	
	distanceX = distanceX + speedX*kFilteringFactor;
	distanceY = distanceY + speedY*kFilteringFactor;
	distanceZ = distanceZ + speedZ*kFilteringFactor;
	[distance_x setText:[NSString stringWithFormat:@"%.4f", distanceX ]];
	[distance_y setText:[NSString stringWithFormat:@"%.4f", distanceY ]];
	[distance_z setText:[NSString stringWithFormat:@"%.4f", distanceZ ]];
}

/* teslameter */
// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    // Update the labels with the raw x, y, and z values.
	[xLabel setText:[NSString stringWithFormat:@"%.1f", heading.x]];
	[yLabel setText:[NSString stringWithFormat:@"%.1f", heading.y]];
	[zLabel setText:[NSString stringWithFormat:@"%.1f", heading.z]];
	
    // Compute and display the magnitude (size or strength) of the vector.
	//      magnitude = sqrt(x^2 + y^2 + z^2)
	CGFloat magnitude = sqrt(heading.x*heading.x + heading.y*heading.y + heading.z*heading.z);
    [magnitudeLabel setText:[NSString stringWithFormat:@"%.1f", magnitude]];
	
	// Update the graph with the new magnetic reading.
	// [graphView updateHistoryWithX:heading.x y:heading.y z:heading.z];
}

// This delegate method is invoked when the location managed encounters an error condition.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        // This error indicates that the user has denied the application's request to use location services.
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        // This error indicates that the heading could not be determined, most likely because of strong magnetic interference.
    }
}



/* buttons */
- (IBAction) button01pressed:(id)sender {
	/* accelerometer */
	acc_x.text= @"haha";
	accelX = 0; accelY = 0; accelZ = 0;
	speedX = 0; speedY = 0; speedZ = 0;
	distanceX = 0; distanceY = 0; distanceZ = 0;
	[self configureAccelerometer];
	
	/* teslameter */
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	// heading service configuration
	locationManager.headingFilter = kCLHeadingFilterNone;
	// setup delegate callbacks
	locationManager.delegate = self;
	// start the compass
	[locationManager startUpdatingHeading];
}

- (IBAction) button02pressed:(id)sender {
}

@end

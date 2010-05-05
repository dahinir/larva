//
//  MainViewController.m
//  larva
//
//  Created by Daehyeon Shin on 4/13/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController

@synthesize window;

/* accelerometer */
@synthesize xDistanceLabel, yDistanceLabel, zDistanceLabel;
@synthesize xVelocityLabel, yVelocityLabel, zVelocityLabel;
@synthesize xAccelerationLabel, yAccelerationLabel, zAccelerationLabel;
#define kFilteringFactor 0.1

/* teslameter */
@synthesize magnitudeLabel;
@synthesize xTeslaLabel;
@synthesize yTeslaLabel;
@synthesize zTeslaLabel;
@synthesize locationManager;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Override point for customization after application launch
	[window makeKeyAndVisible];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
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
	// low pass filter isolate the effects of gravity
	// high pass fileter that u can use to remove the effects of gravity
	xAcceleration = acceleration.x - ( (acceleration.x * kFilteringFactor) + (xAcceleration * (1.0 - kFilteringFactor)) );
    yAcceleration = acceleration.y - ( (acceleration.y * kFilteringFactor) + (yAcceleration * (1.0 - kFilteringFactor)) );
    zAcceleration = acceleration.z - ( (acceleration.z * kFilteringFactor) + (zAcceleration * (1.0 - kFilteringFactor)) );
	[xAccelerationLabel setText:[NSString stringWithFormat:@"%.4f", xAcceleration ]];
	[yAccelerationLabel setText:[NSString stringWithFormat:@"%.4f", yAcceleration ]];
	[zAccelerationLabel setText:[NSString stringWithFormat:@"%.4f", zAcceleration ]];
	
	xVelocity = xVelocity + xAcceleration*kFilteringFactor;
	yVelocity = yVelocity + yAcceleration*kFilteringFactor;
	zVelocity = zVelocity + zAcceleration*kFilteringFactor;
	[xVelocityLabel setText:[NSString stringWithFormat:@"%.4f", xVelocity ]];
	[yVelocityLabel setText:[NSString stringWithFormat:@"%.4f", yVelocity ]];
	[zVelocityLabel setText:[NSString stringWithFormat:@"%.4f", zVelocity ]];
	
	xDistance = xDistance + xVelocity*kFilteringFactor;
	yDistance = yDistance + yVelocity*kFilteringFactor;
	zDistance = zDistance + zVelocity*kFilteringFactor;
	[xDistanceLabel setText:[NSString stringWithFormat:@"%.4f", xDistance ]];
	[yDistanceLabel setText:[NSString stringWithFormat:@"%.4f", yDistance ]];
	[zDistanceLabel setText:[NSString stringWithFormat:@"%.4f", zDistance ]];
}

/* teslameter */
// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    // Update the labels with the raw x, y, and z values.
	xTesla = heading.x;
	yTesla = heading.y;
	zTesla = heading.z;
	[xTeslaLabel setText:[NSString stringWithFormat:@"%.2f", xTesla]];
	[yTeslaLabel setText:[NSString stringWithFormat:@"%.2f", yTesla]];
	[zTeslaLabel setText:[NSString stringWithFormat:@"%.2f", zTesla]];
	
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

// initialize variables
- (IBAction) button01pressed:(id)sender {
	/* accelerometer */
	xAccelerationLabel.text= @"haha";
	xAcceleration = 0; yAcceleration = 0; zAcceleration = 0;
	xVelocity = 0; yVelocity = 0; zVelocity = 0;
	xDistance = 0; yDistance = 0; zDistance = 0;
	[self configureAccelerometer];
	
	/* teslameter */
	xTesla = 0; yTesla = 0; zTesla = 0;
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


- (void)dealloc {	
	/* teslameter */
	[magnitudeLabel release];
	[xTeslaLabel release];
	[yTeslaLabel release];
	[zTeslaLabel release];
	// Stop the compass
	[locationManager stopUpdatingHeading];
    [locationManager release];
	
	/* default */
	[window release];
    [super dealloc];
}


@end

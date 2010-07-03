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
#define kFilteringFactor	0.1		// filtering factor to generate a value that uses 10 percent of the unfiltered acceleration data and 90 percent of the previously filtered value.
#define kAccelerometerFrequency	50.0	// (50Hz) 100 is max (10 milliseconds)

/* CLLocationManager */
@synthesize locationManager;

/* teslameter */
@synthesize magnitudeLabel;
@synthesize xTeslaLabel;
@synthesize yTeslaLabel;
@synthesize zTeslaLabel;

/* GPS */
@synthesize startingPoint;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize horizontalAccuracyLabel;
@synthesize altitudeLabel;
@synthesize verticalAccuracyLabel;
@synthesize distanceTraveledLabel;

/* network log */
@synthesize testLabel, testLabel2;
#define kServerURL	@"http://dasolute.com:8080/example/documents/create.do"


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
	theAccelerometer.updateInterval = 1 / kAccelerometerFrequency;
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

	
	/* for network log */
	sampleTime = sampleTime +1000/kAccelerometerFrequency;
	sensorDatas[sampleCount01].sampleCount = sampleCount01;
	sensorDatas[sampleCount01].millisecond = sampleTime;
	
	sensorDatas[sampleCount01].xAcceleration = xAcceleration;
	sensorDatas[sampleCount01].yAcceleration = yAcceleration;
	sensorDatas[sampleCount01].zAcceleration = zAcceleration;
	
	sensorDatas[sampleCount01].xTesla = xTesla;
	sensorDatas[sampleCount01].yTesla = yTesla;
	sensorDatas[sampleCount01].zTesla = zTesla;
	
	sensorDatas[sampleCount01].latitude = latitude;
	sensorDatas[sampleCount01].longitude = longitude;
	sensorDatas[sampleCount01].altitude = altitude;
	sensorDatas[sampleCount01].horizontalAccuracy = horizontalAccuracy;
	sensorDatas[sampleCount01].verticalAccuracy = verticalAccuracy;
	
	sensorDatas[sampleCount01].xVelocity = xVelocity;
	sensorDatas[sampleCount01].yVelocity = yVelocity;
	sensorDatas[sampleCount01].zVelocity = zVelocity;
	
	sensorDatas[sampleCount01].xDistance = xDistance;
	sensorDatas[sampleCount01].yDistance = yDistance;
	sensorDatas[sampleCount01].zDistance = zDistance;
	
	testLabel.text = [[NSString alloc] initWithFormat:@"accel called : %i", sampleCount01 ];
	
	if (sampleCount01 == 0) {
		[logDataString appendString:@"internalId=&ownerId=1&receiverId=2&belongTo=3&writerName=dahini&title=IphoneSensorData&content="];
		[logDataString appendFormat:@"<updatedGMT>%@</updatedGMT>\n", [NSDate date] ];
	}
	[logDataString appendFormat:@"%@\n", sensorDatas[sampleCount01].toXMLString];

	sampleCount01++;
	if (sampleCount01 == kLogFrequency ) {
		[logDataString appendString:@"\n\n"];
		[logDataString appendString:@"&widthPixel=&heighPixel=&horizontalPercent=&verticalPercent="];
		
		NSData *logData = [logDataString dataUsingEncoding:NSUTF8StringEncoding];
		[client sendPOSTWithData:logData waitForReply:FALSE];
		
		[logDataString setString:@""];
		sampleCount01 = 0;
		/* 
		UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"100!!" message:@"message" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil] autorelease];
		[myAlert show];
		 */
	}
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
	
	/* for network log */
	testLabel2.text = [[NSString alloc] initWithFormat:@"tesla called : %i", sampleCount02 ];
	sampleCount02++;
	if (sampleCount02 == kLogFrequency)
		sampleCount02 = 0;
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

/* GPS */
- (void)locationManager:(CLLocationManager *)manager
		didUpdateToLocation:(CLLocation *)newLocation
		fromLocation:(CLLocation *)oldLocation {
	if (startingPoint == nil)
		self.startingPoint = newLocation;
	latitude = newLocation.coordinate.latitude;
	longitude = newLocation.coordinate.longitude;
	altitude = newLocation.altitude;
	horizontalAccuracy = newLocation.horizontalAccuracy;
	verticalAccuracy = newLocation.verticalAccuracy;
	
	NSString *latitudeString = [[NSString alloc] initWithFormat:@"%g°", latitude];
	latitudeLabel.text = latitudeString;
	[latitudeString release];
	
	NSString *longitudeString = [[NSString alloc] initWithFormat:@"%g°", longitude];
	longitudeLabel.text = longitudeString;
	[longitudeString release];
	
	NSString *altitudeString = [[NSString alloc] initWithFormat:@"%gm", altitude];
	altitudeLabel.text = altitudeString;
	[altitudeString release];
	
	NSString *horizontalAccuracyString = [[NSString alloc] initWithFormat:@"%gm", horizontalAccuracy];
	horizontalAccuracyLabel.text = horizontalAccuracyString;
	[horizontalAccuracyString release];

	NSString *verticalAccuracyString = [[NSString alloc] initWithFormat:@"%gm", verticalAccuracy];
	verticalAccuracyLabel.text = verticalAccuracyString;
	[verticalAccuracyString release];
	
	CLLocationDistance distance = [newLocation getDistanceFrom:startingPoint];
	NSString *distanceString = [[NSString alloc] initWithFormat:@"%gm", distance];
	distanceTraveledLabel.text = distanceString;
	[distanceString release];
	
	/* for network log */

}



/* buttons */

// initialize variables
- (IBAction) button01pressed:(id)sender {
	NSLog(@"button 01 pressed!!");
	temp = 0;
	
	/* accelerometer */
	xAccelerationLabel.text= @"yeah!";
	xAcceleration = 0; yAcceleration = 0; zAcceleration = 0;
	xVelocity = 0; yVelocity = 0; zVelocity = 0;
	xDistance = 0; yDistance = 0; zDistance = 0;
	[self configureAccelerometer];
	
	/* CLLocation */
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	// setup delegate callbacks
	locationManager.delegate = self;
	
	/* teslameter */
	xTesla = 0; yTesla = 0; zTesla = 0;
	// heading service configuration
	locationManager.headingFilter = kCLHeadingFilterNone;
	// start the compass
	[locationManager startUpdatingHeading];
	
	/* GPS */
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];

	/* for data log */
	logDataString = [[NSMutableString alloc] initWithCapacity:1024 ];
	client = [[HTTPClient alloc] initWithServerURLString:kServerURL];
	sampleCount01 = 0;
	sampleCount02 = 0;
	sampleTime = 0;
	for (int i=0; i<kLogFrequency; i++) {
		// sensorDatas[i] = [[[SensorData alloc] init] autorelease];
		sensorDatas[i] = [[SensorData alloc] init];
	}
	testLabel.text = [[NSString alloc] initWithFormat:@"01 pushed : %d", -22];
	sensorDatas[3].sampleCount = 78;
}

- (IBAction) button02pressed:(id)sender {
	xAccelerationLabel.text= @"second!";
	NSLog(@"button 02 pressed!!");
	
	/* network test 
	client = [[SOAPClient alloc] init];
	[client sendMessage:@"dummy" waitForReply:FALSE];
	[client release];
	 */
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
	
	/* GPS */
	[startingPoint release];
	[latitudeLabel release];
	[longitudeLabel release];
	[horizontalAccuracyLabel release];
	[altitudeLabel release];
	[verticalAccuracyLabel release];
	[distanceTraveledLabel release];
	
	/* network log */
	[client release];
	[logDataString release];
	for (int i=0; i<kLogFrequency; i++) {
		[sensorDatas[i] release];
	}
	
	/* default */
	[window release];
    [super dealloc];
}


@end

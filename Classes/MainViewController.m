//
//  MainViewController.m
//  larva
//
//  Created by Daehyeon Shin on 4/13/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import "MainViewController.h"
#import "AccelerometerFilter.h"

@implementation MainViewController

@synthesize window;

/* accelerometer */
@synthesize xDistanceLabel, yDistanceLabel, zDistanceLabel;
@synthesize xVelocityLabel, yVelocityLabel, zVelocityLabel;
@synthesize xAccelerationLabel, yAccelerationLabel, zAccelerationLabel;
#define kFilteringFactor	0.1		// filtering factor to generate a value that uses 10 percent of the unfiltered acceleration data and 90 percent of the previously filtered value.
#define kAccelerometerFrequency	60.0	// (60Hz) 100 is max

/* CLLocationManager */
@synthesize locationManager;

/* teslameter */
@synthesize trueHeadingLabel;
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

/* etc labels */
@synthesize testLabel, testLabel2, testLabel3, testLabel4;

/* network log */
#define kServerURL	@"http://dasolute.com:8080/example/documents/create.do"

/* local methods */
- (void)showAlert {
	UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"100!!" message:@"message" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil] autorelease];
	[myAlert show];
}
- (void)initVariables {
	NSLog(@"init variables");
	temp = 0;
	
	/* set MotionEstimator */
	motionEstimator = [[MotionEstimator alloc] init];
	motionEstimator.delegate = self;
	//[motionEstimator start];
	
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
	// testLabel.text = [[NSString alloc] initWithFormat:@"01 pushed : %d", -22];
	testLabel2.text = [[NSString alloc] initWithFormat:@"is waling? %@", isWalking?@"YES":@"NO" ];
	// sensorDatas[3].sampleCount = 78;
}

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
	[self initVariables];
	
	[motionEstimator start];
	NSLog(@"viewDidLoad");
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



// This is delegate method 
- (void)sensorDataChanged:(SensorData *)sensorData {
	// acceleration view
	[xAccelerationLabel setText:[NSString stringWithFormat:@"%.4f", sensorData.xAcceleration ]];
	[yAccelerationLabel setText:[NSString stringWithFormat:@"%.4f", sensorData.yAcceleration ]];
	[zAccelerationLabel setText:[NSString stringWithFormat:@"%.4f", sensorData.zAcceleration ]];
	
	// tesla view
	[trueHeadingLabel setText:[NSString stringWithFormat:@"%.0f°", sensorData.trueHeading]];
	[xTeslaLabel setText:[NSString stringWithFormat:@"%.2f", sensorData.xTesla]];
	[yTeslaLabel setText:[NSString stringWithFormat:@"%.2f", sensorData.yTesla]];
	[zTeslaLabel setText:[NSString stringWithFormat:@"%.2f", sensorData.zTesla]];
	
	// velocity view
	[xVelocityLabel setText:[NSString stringWithFormat:@"%.4f", sensorData.xVelocity ]];
	[yVelocityLabel setText:[NSString stringWithFormat:@"%.4f", sensorData.yVelocity ]];
	[zVelocityLabel setText:[NSString stringWithFormat:@"%.4f", sensorData.zVelocity ]];
	
	// distance view
	[xDistanceLabel setText:[NSString stringWithFormat:@"%.4f", sensorData.xDistance ]];
	[yDistanceLabel setText:[NSString stringWithFormat:@"%.4f", sensorData.yDistance ]];
	[zDistanceLabel setText:[NSString stringWithFormat:@"%.4f", sensorData.zDistance ]];
	
	// isStep, isWalking view
	if (sensorData.isStep) {
		testLabel.text = [[NSString alloc] initWithFormat:@"STEPED at %ims", sensorData.millisecond ];
	}
	testLabel2.text = [[NSString alloc] initWithFormat:@"is waling? %@", sensorData.isWalking?@"YES":@"NO" ];
	
	// walking direction view
	if (sensorData.walkingDirection == 1) {
		testLabel3.text = @"North";
	}else if (sensorData.walkingDirection == 2) {
		testLabel3.text = @"East";
	}else if (sensorData.walkingDirection == 3) {
		testLabel3.text = @"South";
	}else { // if 4
		testLabel3.text = @"West";
	}

	// location (by walking)
	testLabel4.text = [[NSString alloc] initWithFormat:@"( %d, %d)", sensorData.xLocation, sensorData.yLocation];

	
	// tesla view
	[trueHeadingLabel setText:[NSString stringWithFormat:@"%.0f°", sensorData.trueHeading]];
	[xTeslaLabel setText:[NSString stringWithFormat:@"%.2f", sensorData.xTesla]];
	[yTeslaLabel setText:[NSString stringWithFormat:@"%.2f", sensorData.yTesla]];
	[zTeslaLabel setText:[NSString stringWithFormat:@"%.2f", sensorData.zTesla]];
	
	// location(maybe GPS) view
	[latitudeLabel setText:[NSString stringWithFormat:@"%g°", sensorData.latitude]];
	[longitudeLabel setText:[NSString stringWithFormat:@"%g°", sensorData.longitude]];
	[altitudeLabel setText:[NSString stringWithFormat:@"%gm", sensorData.altitude]];
	[horizontalAccuracyLabel setText:[NSString stringWithFormat:@"%gm", sensorData.horizontalAccuracy]];
	[verticalAccuracyLabel setText:[NSString stringWithFormat:@"%gm", sensorData.verticalAccuracy]];
	//CLLocationDistance distance = [newLocation getDistanceFrom:startingPoint];
	//[distanceTraveledLabel setText:[NSString stringWithFormat:@"%gm", distance];
	
	// remote log
	if (sampleCount01 == 0) {
		[logDataString appendString:@"internalId=&ownerId=1&receiverId=2&belongTo=3&writerName=dahini&title=IphoneSensorData&content="];
		[logDataString appendFormat:@"<updatedGMT>%@</updatedGMT>\n", [NSDate date] ];
	}
	sensorDatas[sampleCount01] = sensorData;
	[logDataString appendFormat:@"%@\n", sensorDatas[sampleCount01].toXMLString];
	sampleCount01++;
	
	if (sampleCount01 == kLogFrequency ) {
		[logDataString appendString:@"\n\n"];
		[logDataString appendString:@"&widthPixel=&heighPixel=&horizontalPercent=&verticalPercent="];
		
		NSData *logData = [logDataString dataUsingEncoding:NSUTF8StringEncoding];
		if (client != nil )
			[client sendPOSTWithData:logData waitForReply:FALSE];
		
		[logDataString setString:@""];
		sampleCount01 = 0;
	}
}


/* buttons */
- (IBAction) button01pressed:(id)sender {
	NSLog(@"button 01 pressed!!");
	// [motionEstimator start];
}

- (IBAction) button02pressed:(id)sender {
	xAccelerationLabel.text= @"second!";
	NSLog(@"button 02 pressed!!");
	
	/* network test 
	client = [[SOAPClient alloc] init];
	[client sendMessage:@"dummy" waitForReply:FALSE];
	[client release];
	 */
	[self showAlert];
}

- (IBAction) switchButton01pressed:(id)sender {
	if([ ((UISwitch *) sender) isOn] == YES ){
		NSLog(@"it's on");
		motionEstimator.isPaused = NO;
	}else {
		NSLog(@"it's off");
		motionEstimator.isPaused = YES;
	}
}



- (void)dealloc {	
	/* teslameter */
	[trueHeadingLabel release];
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

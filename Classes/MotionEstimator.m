//
//  MotionEstimator.m
//  larva
//
//  Created by Daehyeon Shin on 8/13/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import "MotionEstimator.h"
#import "AccelerometerFilter.h"

@implementation MotionEstimator

@synthesize isPaused;
@synthesize delegate;
@synthesize accelerometerFrequency;
@synthesize sensorData;

/* CLLocationManager */
@synthesize locationManager;
@synthesize startingPoint;

#define defaultAccelerometerFrequency	60.0	// (60Hz) 100 is max

/* setting default values */
- (id) init{
	if (self = [super init]) {
		isPaused = YES;
		
		/* sensorData bean */
		sensorData = [[SensorData alloc] init];
		
		/* for accelerometer */
		accelerometerFrequency = defaultAccelerometerFrequency;
		xAcceleration = 0; yAcceleration = 0; zAcceleration = 0;
		
		/* for teslameter */
		xTesla = 0; yTesla = 0; zTesla = 0;
		
		/* for velocity, distance */
		xVelocity = 0; yVelocity = 0; zVelocity = 0;
		xDistance = 0; yDistance = 0; zDistance = 0;
		
		/* for walking estimation */
		sampleTime = 0;
		isStep = NO;
		isWalking = NO;
		lastStepTime = 0;
		wavePositiveFlag = NO;
		waveNegativeFlag = NO;
		zAccelerationPrev = 0.0;
		waveIntegral = 0.0;
	}
	return self;
}

/* starting estimation */
- (void) start{
	
	/* Accelerometer */
	UIAccelerometer* theAccelerometer = [UIAccelerometer sharedAccelerometer];
	theAccelerometer.updateInterval = 1 / accelerometerFrequency;
	theAccelerometer.delegate = self;
	
	// setting high pass filter
	filter =[ [[HighpassFilter class] alloc] initWithSampleRate:accelerometerFrequency cutoffFrequency:5.0];
	// setting low pass filter
	// filter =[ [[LowpassFilter class] alloc] initWithSampleRate:accelerometerFrequency cutoffFrequency:5.0];
	filter.adaptive = NO;
	
	/* CLLocation */
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	locationManager.delegate = self;
	
	// heading service configuration
	locationManager.headingFilter = kCLHeadingFilterNone;
	// start the compass
	[locationManager startUpdatingHeading];
	
	// GPS configuration
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	// start GPS
	[locationManager startUpdatingLocation];
	
}


/* This is delegate method(UIAccelerometerDelegate) */
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	if (isPaused) {
		return;
	}

	/* filtering acceleration data */
	[filter addAcceleration:acceleration];
	xAcceleration = filter.x;
	yAcceleration = filter.y;
	zAcceleration = filter.z;
	
	/* estimate velocity */
	xVelocity = xVelocity + xAcceleration * 1/accelerometerFrequency;
	yVelocity = yVelocity + yAcceleration * 1/accelerometerFrequency;
	zVelocity = zVelocity + zAcceleration * 1/accelerometerFrequency;
	
	/* estimate distance */
	xDistance = xDistance + xVelocity * 1/accelerometerFrequency;
	yDistance = yDistance + yVelocity * 1/accelerometerFrequency;
	zDistance = zDistance + zVelocity * 1/accelerometerFrequency;

	
	/* estimate walking */
	sampleTime = sampleTime + 1000/accelerometerFrequency;
	waveIntegral = waveIntegral + zAcceleration;
	
	isStep = NO;
	if (zAcceleration*zAccelerationPrev < 0) {
		// positive
		if (waveIntegral > 0.08) {
			if ( !waveNegativeFlag) {
				wavePositiveFlag = YES;
				wavePositiveTime = sampleTime;
			}
			// negative
		}else if (waveIntegral < -1.0){
			if ( wavePositiveFlag ){
				waveNegativeFlag = YES;
				waveNegativeTime = sampleTime;
			}
		}
		if (wavePositiveFlag && waveNegativeFlag) {
			if ( (waveNegativeTime - wavePositiveTime) < 495 && waveIntegral < 7.0 ){
				isWalking = YES;
				isStep = YES;
				lastStepTime = sampleTime;
				//testLabel.text = [[NSString alloc] initWithFormat:@"STEPED at %ims", sampleTime ];
			}
			wavePositiveFlag = NO;
			waveNegativeFlag = NO;
		}
		waveIntegral = 0.0;
	}
	
	// 정지상태 감지
	if ( (sampleTime-lastStepTime) > 850) {
		//testLabel2.text = [[NSString alloc] initWithFormat:@"STOP now %ims", sampleTime ];
		isWalking = NO;
	}
	zAccelerationPrev = zAcceleration;
	// testLabel2.text = [[NSString alloc] initWithFormat:@"is waling? %@", isWalking?@"YES":@"NO" ];

	
	// setting value
	sensorData.isStep = isStep;
	sensorData.isWalking = isWalking;
	// sensorData.sampleCount = sampleCount01;
	sensorData.millisecond = sampleTime;
	
	sensorData.xAcceleration = xAcceleration;
	sensorData.yAcceleration = yAcceleration;
	sensorData.zAcceleration = zAcceleration;
	
	// estimated
	sensorData.xVelocity = xVelocity;
	sensorData.yVelocity = yVelocity;
	sensorData.zVelocity = zVelocity;
	
	sensorData.xDistance = xDistance;
	sensorData.yDistance = yDistance;
	sensorData.zDistance = zDistance;
	
	
	/* invoke delegate */
	if(delegate && [delegate respondsToSelector:@selector(sensorDataChanged:)] )
		[delegate sensorDataChanged:sensorData];
}


/* This is delegate method(CLLocationManagerDelegate) */
// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    // Update the labels with the raw x, y, and z values.
	sensorData.trueHeading  = heading.trueHeading;
	sensorData.xTesla = heading.x;
	sensorData.yTesla = heading.y;
	sensorData.zTesla = heading.z;
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

// This delegate method is invoked when the location manager has location(GPS) data.
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	if (startingPoint == nil)
		self.startingPoint = newLocation;
	sensorData.latitude = newLocation.coordinate.latitude;
	sensorData.longitude = newLocation.coordinate.longitude;
	sensorData.altitude = newLocation.altitude;
	sensorData.horizontalAccuracy = newLocation.horizontalAccuracy;
	sensorData.verticalAccuracy = newLocation.verticalAccuracy;
}


@end

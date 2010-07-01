//
//  MainViewController.h
//  larva
//
//  Created by Daehyeon Shin on 4/13/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "SensorData.h"
#import "HTTPClient.h"

/* network log */
#define kLogFrequency	100	// send log throgh network every 100 sample

@interface MainViewController : UIViewController<UIAccelerometerDelegate, CLLocationManagerDelegate> 
{
    UIWindow *window;
	
	UILabel *testLabel, *testLabel2;
	
	/* at refactoring	 xAccel,yAccel, zTesla ... */
	// accelerometer
	float xAcceleration, yAcceleration, zAcceleration;
	float xVelocity, yVelocity, zVelocity;
	float xDistance, yDistance, zDistance;
	UILabel *xDistanceLabel, *yDistanceLabel, *zDistanceLabel;
	UILabel *xVelocityLabel, *yVelocityLabel, *zVelocityLabel;
	UILabel *xAccelerationLabel, *yAccelerationLabel, *zAccelerationLabel;
	
	CLLocationManager *locationManager;	
	CLLocation *startingPoint;
	
	// teslameter
	float xTesla, yTesla, zTesla;
	UILabel *magnitudeLabel;
	UILabel *xTeslaLabel;
	UILabel *yTeslaLabel;
	UILabel *zTeslaLabel;
	
	// GPS
	UILabel *latitudeLabel;
	UILabel *longitudeLabel;
	UILabel *horizontalAccuracyLabel;
	UILabel *altitudeLabel;
	UILabel *verticalAccuracyLabel;
	UILabel *distanceTraveledLabel;
	
	/* for data log */
	int sampleCount01, sampleCount02, temp;
	long sampleTime;
	HTTPClient *client;
	SensorData *sensorDatas[kLogFrequency];
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UILabel *testLabel, *testLabel2;

// accelerometer
@property (nonatomic, retain) IBOutlet UILabel *xDistanceLabel, *yDistanceLabel, *zDistanceLabel;
@property (nonatomic, retain) IBOutlet UILabel *xVelocityLabel, *yVelocityLabel, *zVelocityLabel;
@property (nonatomic, retain) IBOutlet UILabel *xAccelerationLabel, *yAccelerationLabel, *zAccelerationLabel;

// CLLocationManager
@property (nonatomic, retain) CLLocationManager *locationManager;

// teslameter
@property (nonatomic, retain) IBOutlet UILabel *magnitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *xTeslaLabel;
@property (nonatomic, retain) IBOutlet UILabel *yTeslaLabel;
@property (nonatomic, retain) IBOutlet UILabel *zTeslaLabel;

// GPS
@property (nonatomic, retain) CLLocation *startingPoint;
@property (nonatomic, retain) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *horizontalAccuracyLabel;
@property (nonatomic, retain) IBOutlet UILabel *altitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *verticalAccuracyLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceTraveledLabel;

- (IBAction) button01pressed:(id)sender;
- (IBAction) button02pressed:(id)sender;

@end

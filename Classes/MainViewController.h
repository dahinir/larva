//
//  MainViewController.h
//  larva
//
//  Created by Daehyeon Shin on 4/13/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MainViewController : UIViewController<UIAccelerometerDelegate, CLLocationManagerDelegate> 
{
    UIWindow *window;
	
	// at refactoring
	// xAccel,yAccel, zTesla ...
	
	// accelerometer
	int temp;
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
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

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
@property (retain, nonatomic) CLLocation *startingPoint;
@property (retain, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *horizontalAccuracyLabel;
@property (retain, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *verticalAccuracyLabel;
@property (retain, nonatomic) IBOutlet UILabel *distanceTraveledLabel;

- (IBAction) button01pressed:(id)sender;
- (IBAction) button02pressed:(id)sender;

@end

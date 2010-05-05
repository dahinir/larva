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
	
	// teslameter
	float xTesla, yTesla, zTesla;
	UILabel *magnitudeLabel;
	UILabel *xTeslaLabel;
	UILabel *yTeslaLabel;
	UILabel *zTeslaLabel;
	CLLocationManager *locationManager;	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

// accelerometer
@property (nonatomic, retain) IBOutlet UILabel *xDistanceLabel, *yDistanceLabel, *zDistanceLabel;
@property (nonatomic, retain) IBOutlet UILabel *xVelocityLabel, *yVelocityLabel, *zVelocityLabel;
@property (nonatomic, retain) IBOutlet UILabel *xAccelerationLabel, *yAccelerationLabel, *zAccelerationLabel;

// teslameter
@property (nonatomic, retain) IBOutlet UILabel *magnitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *xTeslaLabel;
@property (nonatomic, retain) IBOutlet UILabel *yTeslaLabel;
@property (nonatomic, retain) IBOutlet UILabel *zTeslaLabel;
@property (nonatomic, retain) CLLocationManager *locationManager;

- (IBAction) button01pressed:(id)sender;
- (IBAction) button02pressed:(id)sender;

@end

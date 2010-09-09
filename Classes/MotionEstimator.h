//
//  MotionEstimator.h
//  larva
//
//  Created by Daehyeon Shin on 8/13/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "SensorData.h"

@class AccelerometerFilter;

@protocol MotionEstimatorDelegate<NSObject>

@optional
- (void)sensorDataChanged:(SensorData *)sensorData;

@end


@interface MotionEstimator : NSObject<UIAccelerometerDelegate, CLLocationManagerDelegate> {
	id delegate;
	BOOL isPaused;
	
	/* for accelerometer */
	float accelerometerFrequency;
	float xAcceleration, yAcceleration, zAcceleration;
	
	/* CoreLocation */
	CLLocationManager *locationManager;
	CLLocation *startingPoint;
	
	/* for teslameter */
	float xTesla, yTesla, zTesla;
	float trueHeading;
	
	/* for GPS */
	double latitude, longitude, altitude;
	double horizontalAccuracy, verticalAccuracy;
	
	/* for velocity, distance */
	float xVelocity, yVelocity, zVelocity;
	float xDistance, yDistance, zDistance;
	
	AccelerometerFilter *filter;
	
	/* for walking estimation */
	long sampleTime;
	float zAccelerationPrev;
	BOOL isStep, isWalking;
	long wavePositiveTime, waveNegativeTime, lastStepTime;
	BOOL wavePositiveFlag, waveNegativeFlag;
	float waveIntegral;
	
	/* share estimated motion by sensor data */
	SensorData *sensorData;
}
@property BOOL isPaused;

@property float accelerometerFrequency;
@property(readonly) SensorData *sensorData;
@property(nonatomic,assign) id<MotionEstimatorDelegate> delegate;

// CLLocationManager
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *startingPoint;


- (void) start;

@end

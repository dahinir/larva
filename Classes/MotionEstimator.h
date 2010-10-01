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
#import "MediumFilter.h"

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
	MediumFilter *mediumX, *mediumY,*mediumZ;
	
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
	
	/* for walking direction */
	float relativeNorth;
	int walkingDirection;	// 1:+y, 2:+x, 3:-y, 4:-x
	//float lastTrueHeading;
	
	/* for location (by walking) */
	int xLocation, yLocation;
	
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

//
//  SensorData.h
//  larva
//
//  Created by Daehyeon Shin on 6/20/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SensorData : NSObject {
	/* not for this
    NSString *title;
    NSString *artist;
    NSString *album;
    NSDate *releaseDate;
    NSString *category;
*/
	
	/* real */
	int sampleCount;
	long millisecond;
	
	float xAcceleration, yAcceleration, zAcceleration;
	float xTesla, yTesla, zTesla;
	float trueHeading;
	double latitude, longitude, altitude, horizontalAccuracy, verticalAccuracy;
	
	BOOL isStep, isWalking;
	
	float xVelocity, yVelocity, zVelocity;
	float xDistance, yDistance, zDistance;
}

/* not for this 
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSDate *releaseDate;
@property (nonatomic, copy) NSString *category;
*/
 
/* real */
@property int sampleCount;
@property long millisecond;

@property float xAcceleration, yAcceleration, zAcceleration;
@property float xTesla, yTesla, zTesla;
@property float trueHeading;
@property double latitude, longitude, altitude, horizontalAccuracy, verticalAccuracy;

@property BOOL isStep, isWalking;

@property float xVelocity, yVelocity, zVelocity;
@property float xDistance, yDistance, zDistance;

@property(readonly) NSString *toXMLString;

@end
//
//  SensorData.m
//  larva
//
//  Created by Daehyeon Shin on 6/20/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import "SensorData.h"


@implementation SensorData

/* not for this
@synthesize title, artist, album, releaseDate, category;
*/

@synthesize sampleCount;

@synthesize xAcceleration, yAcceleration, zAcceleration;
@synthesize xTesla, yTesla, zTesla;

@synthesize xVelocity, yVelocity, zVelocity;
@synthesize xDistance, yDistance, zDistance;


- (void)dealloc {
	/* not for this
    [title release];
    [artist release];
    [album release];
    [releaseDate release];
    [category release];
	 */
    [super dealloc];
}

@end
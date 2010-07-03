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

@synthesize sampleCount, millisecond;

@synthesize xAcceleration, yAcceleration, zAcceleration;
@synthesize xTesla, yTesla, zTesla;
@synthesize latitude, longitude, altitude, horizontalAccuracy, verticalAccuracy;

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

- (NSString *)toXMLString {
/*	return [NSString stringWithFormat:
			@"<sensorData>\
			<accelerometer>\
			<x>%.4f", xAcceleration];
*/
	return [NSString stringWithFormat:
		@"<sample time=%ldms>\n\
	<accelerometer>\n\
		<x>%.4f</x>\n\
		<y>%.4f</y>\n\
		<z>%.4f</z>\n\
	</accelerometer>\n\
	<tesla>\n\
		<x>%.4f</x>\n\
		<y>%.4f</y>\n\
		<z>%.4f</z>\n\
	</tesla>\n\
	<GPS>\n\
		<latitude>%g°</latitude>\n\
		<longitude>%g°</longitude>\n\
		<altitude>%gm</altitude>\n\
		<horizontalAccuracy>%gm</horizontalAccuracy>\n\
		<verticalAccuracy>%gm</verticalAccuracy>\n\
	</GPS>\n\
	<estimated>\n\
			<velocity>\n\
				<x>%.4f</x>\n\
				<y>%.4f</y>\n\
				<z>%.4f</z>\n\
			</velocity>\n\
			<distance>\n\
				<x>%.4f</x>\n\
				<y>%.4f</y>\n\
				<z>%.4f</z>\n\
			</distance>\n\
	</estimated>\n\
</sample>\n", millisecond, 
			xAcceleration, yAcceleration, zAcceleration, 
			xTesla, yTesla, zTesla , 
			latitude, longitude, altitude, horizontalAccuracy, verticalAccuracy,
			xVelocity, yVelocity, zVelocity,
			xDistance, yDistance, zDistance];
 
}

@end
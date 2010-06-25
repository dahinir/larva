//
//  SensorData.m
//  larva
//
//  Created by Daehyeon Shin on 6/20/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import "SensorData.h"


@implementation SensorData

@synthesize title, artist, album, releaseDate, category;

- (void)dealloc {
    [title release];
    [artist release];
    [album release];
    [releaseDate release];
    [category release];
    [super dealloc];
}

@end
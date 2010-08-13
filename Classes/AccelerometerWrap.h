//
//  AccelerometerWrap.h
//  larva
//
//  Created by Daehyeon Shin on 8/13/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AccelerometerWrap : NSObject<UIAccelerometerDelegate> {
	float x, y, z;
}

@property(readonly) float x, y, z;

@end

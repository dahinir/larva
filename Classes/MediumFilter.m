//
//  MediumFilter.m
//  larva
//
//  Created by Kwangjin Hong on 10. 9. 9..
//  Copyright 2010 숭실대학교. All rights reserved.
//

#import "MediumFilter.h"


@implementation MediumFilter

-(id)initWithMatrixSize:(int)matrixSize {
	self = [super init];
	if (self != nil) {
		endPoint = 0;
		kMatrixSize = matrixSize;
		// rawMatrix = float *rawMatrix[matrixSize];
	}
	return self;
}

// private method
- (int) nextPointOf:(int)point{
	point++;
	if (point >= kMatrixSize) {
		point = 0;
	}
	return point;
}

- (float)update:(float)newValue {
	rawMatrix[endPoint] = newValue;
	
	endPoint = [self nextPointOf:endPoint];
	
	return 0.0;
}

@end

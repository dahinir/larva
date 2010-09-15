//
//  MediumFilter.m
//  larva
//
//  Created by Kwangjin Hong on 10. 9. 9..
//  Copyright 2010 숭실대학교. All rights reserved.
//

#import "MediumFilter.h"


@implementation MediumFilter

// -(id)initWithMatrixSize:(int)matrixSize {
-(id)init {
	self = [super init];
	if (self != nil) {
		endPoint = 0;
		
		// kMatrixSize = matrixSize;
		for (int i = 0; i < kMatrixSize; i++) {
			sortedMatrix[i] = 0;
			beforeMatrix[i] = 0;
			afterMatrix[i] = 0;
		}
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
	beforeMatrix[endPoint] = newValue;
	
	endPoint = [self nextPointOf:endPoint];
	
	return 0.0;
}

@end


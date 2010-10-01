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
		//lastValue = 0.0;
		
		// kMatrixSize = matrixSize;
		for (int i = 0; i < kMatrixSize; i++) {
			// sortedMatrix[i] = 0.0;
			beforeMatrix[i] = 0.0;
			// afterMatrix[i] = 0.0;
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
	
	// find medium
	upCount = 0;
	downCount = 0;
	for (int i=0; i < kMatrixSize; i++) {
		for (int j=0; j < kMatrixSize; j++) {
			if (beforeMatrix[i] <= beforeMatrix[j])
				downCount++;
			if (beforeMatrix[i] >= beforeMatrix[j]) 
				upCount++;
		}
		if (upCount == kMediumIndex || (upCount >= kMediumIndex && downCount >= kMediumIndex) ) {
			mediumValue = beforeMatrix[i];
			break;
		}
	}

	
	endPoint = [self nextPointOf:endPoint];
	
	return mediumValue;
}

@end




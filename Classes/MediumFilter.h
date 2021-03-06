//
//  MediumFilter.h
//  larva
//
//  Created by Kwangjin Hong on 10. 9. 9..
//  Copyright 2010 숭실대학교. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMatrixSize	5
#define kMediumIndex	3


@interface MediumFilter : NSObject {

	float sortedMatrix[kMatrixSize], beforeMatrix[kMatrixSize], afterMatrix[kMatrixSize];
	float mediumValue, lastValue;
	int endPoint, upCount,downCount;
}
- (float)update:(float)newValue;

@end


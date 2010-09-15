//
//  MediumFilter.h
//  larva
//
//  Created by Kwangjin Hong on 10. 9. 9..
//  Copyright 2010 숭실대학교. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMatrixSize	5
#define kMedium	3


@interface MediumFilter : NSObject {

	float sortedMatrix[kMatrixSize], beforeMatrix[kMatrixSize], afterMatrix[kMatrixSize];
	int endPoint;
}

@end

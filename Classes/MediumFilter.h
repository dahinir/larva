//
//  MediumFilter.h
//  larva
//
//  Created by Kwangjin Hong on 10. 9. 9..
//  Copyright 2010 숭실대학교. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MediumFilter : NSObject {

	float *rawMatrix;
	int endPoint, kMatrixSize;
}

@end

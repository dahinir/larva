//
//  SensorData.h
//  larva
//
//  Created by Daehyeon Shin on 6/20/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SensorData : NSObject {
    NSString *title;
    NSString *artist;
    NSString *album;
    NSDate *releaseDate;
    NSString *category;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSDate *releaseDate;
@property (nonatomic, copy) NSString *category;

@end
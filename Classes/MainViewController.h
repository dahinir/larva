//
//  MainViewController.h
//  larva
//
//  Created by Daehyeon Shin on 4/13/10.
//  Copyright 2010 dasolute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MainViewController : UIViewController<UIAccelerometerDelegate, CLLocationManagerDelegate> 
{
    UIWindow *window;
	
	// accelerometer
	int temp;
	float accelX, accelY, accelZ;
	float speedX, speedY, speedZ;
	float distanceX, distanceY, distanceZ;
	IBOutlet UITextField *distance_x, *distance_y, *distance_z;
	IBOutlet UITextField *speed_x, *speed_y, *speed_z;
	IBOutlet UITextField *acc_x, *acc_y, *acc_z;
	
	// teslameter
	UILabel *magnitudeLabel;
	UILabel *xLabel;
	UILabel *yLabel;
	UILabel *zLabel;
	CLLocationManager *locationManager;	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

// accelerometer
@property (nonatomic, retain) IBOutlet UITextField *distance_x, *distance_y, *distance_z;
@property (nonatomic, retain) IBOutlet UITextField *speed_x, *speed_y, *speed_z;
@property (nonatomic, retain) IBOutlet UITextField *acc_x, *acc_y, *acc_z;

// teslameter
@property (nonatomic, retain) IBOutlet UILabel *magnitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *xLabel;
@property (nonatomic, retain) IBOutlet UILabel *yLabel;
@property (nonatomic, retain) IBOutlet UILabel *zLabel;
@property (nonatomic, retain) CLLocationManager *locationManager;

- (IBAction) button01pressed:(id)sender;
- (IBAction) button02pressed:(id)sender;

@end

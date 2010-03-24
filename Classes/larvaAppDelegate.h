//
//  larvaAppDelegate.h
//  larva
//
//  Created by Daehyeon Shin on 2/10/10.
//  Copyright dasolute 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface larvaAppDelegate : NSObject <UIApplicationDelegate, UIAccelerometerDelegate> {
    UIWindow *window;
	
	float speedX, speedY, speedZ;
	float distanceX, distanceY, distanceZ;
	
	IBOutlet UITextField *distance_x, *distance_y, *distance_z;
	IBOutlet UITextField *speed_x, *speed_y, *speed_z;
	IBOutlet UITextField *acc_x, *acc_y, *acc_z;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITextField *distance_x, *distance_y, *distance_z;
@property (nonatomic, retain) IBOutlet UITextField *speed_x, *speed_y, *speed_z;
@property (nonatomic, retain) IBOutlet UITextField *acc_x, *acc_y, *acc_z;

- (IBAction) button01pressed:(id)sender;
- (IBAction) button02pressed:(id)sender;

@end


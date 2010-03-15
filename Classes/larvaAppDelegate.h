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
	
	IBOutlet UITextField *acc_x;
	IBOutlet UITextField *acc_y;
	IBOutlet UITextField *acc_z;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITextField *acc_x;
@property (nonatomic, retain) IBOutlet UITextField *acc_y;
@property (nonatomic, retain) IBOutlet UITextField *acc_z;

- (IBAction) button01pressed:(id)sender;
- (IBAction) button02pressed:(id)sender;

@end


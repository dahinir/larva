//
//  AppDelegate.h
//  larva
//
//  Created by Daehyeon Shin on 4/24/10.
//  Copyright 2010 dasolute. All rights reserved.
//

@interface AppDelegate : NSObject<UIApplicationDelegate>
{
	UIWindow *window;
	UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;

@end

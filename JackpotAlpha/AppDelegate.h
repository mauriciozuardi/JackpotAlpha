//
//  AppDelegate.h
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/3/11.
//  Copyright mnmo.com.br 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window_;
	RootViewController	*viewController_;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RootViewController *viewController;

@end

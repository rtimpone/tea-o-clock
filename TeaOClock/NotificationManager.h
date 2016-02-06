//
//  NotificationManager.h
//  TeaOClock
//
//  Created by Rob Timpone on 1/21/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationManager : NSObject

/** Bounce the dock icon until the app becomes active again */
- (void)bounceDockBarIcon;

/** Show an OSX notification to the user letting them know the timer is finished */
- (void)showTimerFinishedUserNotification;

@end

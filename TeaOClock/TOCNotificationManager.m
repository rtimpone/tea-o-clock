//
//  TOCNotificationManager.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/21/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

@import Cocoa;

#import "TOCNotificationManager.h"

@implementation TOCNotificationManager

- (void)bounceDockBarIcon
{
    [[NSApplication sharedApplication] requestUserAttention: NSCriticalRequest];
}

- (void)showTimerFinishedUserNotification
{
    NSUserNotification *notification = [NSUserNotification new];
    notification.title = @"Timer Finished!";
    notification.informativeText = @"Enjoy your tea";
    notification.soundName = NSUserNotificationDefaultSoundName;
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification: notification];
}

@end

//
//  TOCAppDelegate.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/19/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "TOCAppDelegate.h"

@interface TOCAppDelegate () <NSUserNotificationCenterDelegate>

@end

@implementation TOCAppDelegate

- (void)applicationDidFinishLaunching: (NSNotification *)notification
{
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate: self];
}

#pragma mark - User Notification Center Delegate

- (BOOL)userNotificationCenter: (NSUserNotificationCenter *)center shouldPresentNotification: (NSUserNotification *)notification
{
    return YES;
}

@end

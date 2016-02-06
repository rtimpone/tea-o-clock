//
//  UserPreferencesManager.m
//  TeaOClock
//
//  Created by Rob Timpone on 2/6/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "UserPreferencesManager.h"

#define DEFAULT_MINUTES 3

NSString * const kUserDefinedMinutes = @"userDefinedMinutes";

@implementation UserPreferencesManager

+ (void)setUserDefintedMinutes: (NSInteger)minutes
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: @(minutes) forKey: kUserDefinedMinutes];
    [defaults synchronize];
}

+ (NSInteger)userDefinedMinutes
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *userDefinedMinutesNumber = [defaults objectForKey: kUserDefinedMinutes];
    return userDefinedMinutesNumber ? [userDefinedMinutesNumber integerValue] : DEFAULT_MINUTES;
}

@end

//
//  UserPreferencesManager.m
//  TeaOClock
//
//  Created by Rob Timpone on 2/6/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "UserPreferencesManager.h"

#define DEFAULT_MINUTES 3
#define DEFAULT_INTERFACE InterfaceTypeDark

NSString * const kUserDefinedMinutes = @"userDefinedMinutes";
NSString * const kLastInterfaceTypeUsed = @"lastInterfaceTypeUsed";

@implementation UserPreferencesManager

+ (void)setUserDefintedMinutes: (NSInteger)minutes
{
    [self setInteger: minutes forKey: kUserDefinedMinutes];
}

+ (NSInteger)userDefinedMinutes
{
    return [self getIntegerForKey: kUserDefinedMinutes withDefaultValue: DEFAULT_MINUTES];
}

+ (void)setLastInterfaceTypeUsed: (InterfaceType)type
{
    [self setInteger: type forKey: kLastInterfaceTypeUsed];
}

+ (InterfaceType)lastInterfaceTypeUsed
{
    return [self getIntegerForKey: kLastInterfaceTypeUsed withDefaultValue: DEFAULT_INTERFACE];
}

#pragma mark - Helpers

+ (void)setInteger: (NSInteger)integer forKey: (NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: @(integer) forKey: key];
    [defaults synchronize];
}

+ (NSInteger)getIntegerForKey: (NSString *)key withDefaultValue: (NSInteger)defaultValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *object = [defaults objectForKey: key];
    return object ? [object integerValue] : defaultValue;
}

@end

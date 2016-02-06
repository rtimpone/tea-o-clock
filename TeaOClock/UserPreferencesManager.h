//
//  UserPreferencesManager.h
//  TeaOClock
//
//  Created by Rob Timpone on 2/6/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharedConstants.h"

@interface UserPreferencesManager : NSObject

+ (void)setUserDefintedMinutes: (NSInteger)minutes;
+ (NSInteger)userDefinedMinutes;

+ (void)setLastInterfaceTypeUsed: (InterfaceType)type;
+ (InterfaceType)lastInterfaceTypeUsed;

@end

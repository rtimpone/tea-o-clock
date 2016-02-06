//
//  MenuItemManager.h
//  TeaOClock
//
//  Created by Rob Timpone on 2/6/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

@import Cocoa;
@import Foundation;

#import "SharedConstants.h"

@class MenuItemManager;

@protocol MenuItemManagerDelegate <NSObject>

- (void)menuItemManager: (MenuItemManager *)manager didSelectInterfaceType: (InterfaceType)type;

@end

@interface MenuItemManager : NSObject

@property (weak) IBOutlet id <MenuItemManagerDelegate> delegate;

- (void)handleSelectedMenuItem: (NSMenuItem *)item;

@end

//
//  MenuItemManager.m
//  TeaOClock
//
//  Created by Rob Timpone on 2/6/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "MenuItemManager.h"

NSString * const kLightMenuItemTitle = @"Light";
NSString * const kDarkMenuItemTitle = @"Dark";

@implementation MenuItemManager

- (void)handleSelectedMenuItem: (NSMenuItem *)item
{
    [self selectMenuItem: item];
    
    if ([item.title isEqualToString: kLightMenuItemTitle])
    {
        [self.delegate menuItemManager: self didSelectInterfaceType: InterfaceTypeLight];
    }
    else if ([item.title isEqualToString: kDarkMenuItemTitle])
    {
        [self.delegate menuItemManager: self didSelectInterfaceType: InterfaceTypeDark];
    }
}

#pragma mark - Helpers

- (void)selectMenuItem: (NSMenuItem *)selectedItem
{
    NSMenu *menu = (NSMenu *)[[[[NSApplication sharedApplication] mainMenu] itemAtIndex: 1] submenu];
    for (NSMenuItem *item in menu.itemArray)
    {
        item.state = (item == selectedItem);
    }
}

@end

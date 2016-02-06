//
//  InspectableTextField.h
//  TeaOClock
//
//  Created by Rob Timpone on 2/6/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface InspectableTextField : NSTextField

@property (strong) IBInspectable NSColor *activeTextColor;
@property (strong) IBInspectable NSColor *inactiveTextColor;
@property (nonatomic, getter=isActive) BOOL active;

@end

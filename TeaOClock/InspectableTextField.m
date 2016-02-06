//
//  InspectableTextField.m
//  TeaOClock
//
//  Created by Rob Timpone on 2/6/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "InspectableTextField.h"

@implementation InspectableTextField

- (void)setActive: (BOOL)active
{
    self.textColor = active ? self.activeTextColor : self.inactiveTextColor;
}

@end

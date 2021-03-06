//
//  TimerManager.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/21/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

@import AppKit;

#import "TimerManager.h"
#import "UserPreferencesManager.h"

@interface TimerManager ()

@property (nonatomic) NSInteger initialSeconds;
@property (nonatomic) NSInteger secondsRemaining;
@property (strong) NSTimer *timer;

@end

@implementation TimerManager

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSInteger userDefinedMinutes = [UserPreferencesManager userDefinedMinutes];
    self.initialSeconds = userDefinedMinutes * 60;
    self.secondsRemaining = userDefinedMinutes * 60;
}

- (void)startTimer
{
    self.secondsRemaining = self.initialSeconds;
    [self.delegate timerManager: self secondsRemainingDidChange: self.secondsRemaining];
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(decrementSecondsRemaining) userInfo: nil repeats: YES];
}

- (void)stopTimer
{
    [self.timer invalidate];
}

#pragma mark - Setters

- (void)setMinutes: (NSInteger)minutes
{
    self.initialSeconds = minutes * 60;
    self.secondsRemaining = minutes * 60;
}

#pragma mark - Timer Actions

- (void)decrementSecondsRemaining
{
    self.secondsRemaining--;
    [self.delegate timerManager: self secondsRemainingDidChange: self.secondsRemaining];
    
    if (self.secondsRemaining == 0)
    {
        [self stopTimer];
        [self.delegate timerManagerTimerDidFinish: self];
    }
}

@end

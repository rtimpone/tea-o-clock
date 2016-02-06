//
//  TimerManager.h
//  TeaOClock
//
//  Created by Rob Timpone on 1/21/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TimerManager;

@protocol TimerManagerDelegate <NSObject>

/** Called each second as the timer counts down to zero */
- (void)timerManager: (TimerManager *)manager secondsRemainingDidChange: (NSInteger)secondsRemaining;

/** Called when the timer reaches zero seconds remaining */
- (void)timerManagerTimerDidFinish: (TimerManager *)manager;

@end

@interface TimerManager : NSObject

@property (weak) IBOutlet id <TimerManagerDelegate> delegate;
@property (nonatomic) NSInteger minutes;

/** Begins a countdown timer starting with the number of minutes currently set */
- (void)startTimer;

/** Invalidates the current timer and stops the countdown */
- (void)stopTimer;

@end

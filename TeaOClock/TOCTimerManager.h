//
//  TOCTimerManager.h
//  TeaOClock
//
//  Created by Rob Timpone on 1/21/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TOCTimerManager;

@protocol TOCTimerManagerDelegate <NSObject>

/** Called each second as the timer counts down to zero */
- (void)timerManager: (TOCTimerManager *)manager secondsRemainingDidChange: (NSInteger)secondsRemaining;

/** Called when the timer reaches zero seconds remaining */
- (void)timerManagerTimerDidFinish: (TOCTimerManager *)manager;

@end

@interface TOCTimerManager : NSObject

@property (weak) IBOutlet id <TOCTimerManagerDelegate> delegate;
@property (nonatomic) NSInteger minutes;

- (void)startTimer;
- (void)stopTimer;

@end

//
//  TOCInterfaceViewController.h
//  TeaOClock
//
//  Created by Rob Timpone on 1/21/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TimerInterfaceState) {
    TimerInterfaceStateIsCountingDown,
    TimerInterfaceStateIsStopped
};

@protocol TOCInterfaceViewControllerDelegate <NSObject>

/** Tells the delegate to start the timer */
- (void)interfaceControllerRequestsStartTimer: (id)controller;

/** Tells the delegate to stop the timer */
- (void)interfaceControllerRequestsStopTimer: (id)controller;

/** Tells the delegate to update the initial minutes */
- (void)interfaceController: (id)controller requestsSetInitialMinutes: (NSInteger)minutes;

@end

@protocol TOCInterfaceViewController <NSObject>

@property (weak) id <TOCInterfaceViewControllerDelegate> delegate;

/** Updates the interface for a state change, i.e. the timer started or stopped */
- (void)updateInterfaceForStateChanged: (TimerInterfaceState)interfaceState;

/** Updates the interface for a change in the number of seconds remaining */
- (void)updateInterfaceForSecondsRemainingChanged: (NSInteger)secondsRemaining;

@end

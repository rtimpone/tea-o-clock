//
//  TOCMasterViewController.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/19/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "TOCInterfaceViewController.h"
#import "TOCNotificationManager.h"
#import "TOCTimerManager.h"
#import "TOCMasterViewController.h"

@interface TOCMasterViewController () <TOCInterfaceViewControllerDelegate, TOCTimerManagerDelegate>

@property (strong) id <TOCInterfaceViewController> interfaceController;
@property (strong) IBOutlet TOCNotificationManager *notificationManager;
@property (strong) IBOutlet TOCTimerManager *timerManager;

@end

NSString * const kBasicInterviewEmbedSegue = @"BasicInterviewEmbedSegue";

@implementation TOCMasterViewController

- (void)prepareForSegue: (NSStoryboardSegue *)segue sender: (id)sender
{
    if ([segue.identifier isEqualToString: kBasicInterviewEmbedSegue])
    {
        self.interfaceController = segue.destinationController;
        self.interfaceController.delegate = self;
    }
}

#pragma mark - Interface Controller Delegate

- (void)interfaceControllerRequestsStartTimer: (id)controller
{
    [self.timerManager startTimer];
    [self.interfaceController updateInterfaceForStateChanged: TimerInterfaceStateIsCountingDown];
}

- (void)interfaceControllerRequestsStopTimer: (id)controller
{
    [self.timerManager stopTimer];
    [self.interfaceController updateInterfaceForStateChanged: TimerInterfaceStateIsStopped];
}

- (void)interfaceController: (id)controller requestsSetInitialMinutes: (NSInteger)minutes
{
    self.timerManager.minutes = minutes;
}

#pragma mark - Timer Manager Delegate

- (void)timerManager: (TOCTimerManager *)manager secondsRemainingDidChange: (NSInteger)secondsRemaining
{
    [self.interfaceController updateInterfaceForSecondsRemainingChanged: secondsRemaining];
}

- (void)timerManagerTimerDidFinish: (TOCTimerManager *)manager
{
    [self.interfaceController updateInterfaceForStateChanged: TimerInterfaceStateIsStopped];
    
    [self.notificationManager bounceDockBarIcon];
    [self.notificationManager showTimerFinishedUserNotification];
}

@end

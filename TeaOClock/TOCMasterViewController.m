//
//  TOCMasterViewController.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/19/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "TOCTimerManager.h"
#import "TOCMasterViewController.h"

@interface TOCMasterViewController () <TOCTimerManagerDelegate>

@property (weak) IBOutlet NSTextField *minutesLabel;
@property (weak) IBOutlet NSTextField *countdownLabel;
@property (weak) IBOutlet NSStepper *stepper;
@property (weak) IBOutlet NSButton *startButton;
@property (weak) IBOutlet NSButton *stopButton;

@property (strong) IBOutlet TOCTimerManager *timerManager;

@end

typedef NS_ENUM(NSUInteger, CountdownState) {
    CountdownStateIsCountingDown,
    CountdownStateIsStopped
};

@implementation TOCMasterViewController

#pragma mark - Timer Manager Delegate

- (void)timerManager: (TOCTimerManager *)manager secondsRemainingDidChange: (NSInteger)secondsRemaining
{
    static NSDateComponentsFormatter *dcf;
    if (!dcf)
    {
        dcf = [NSDateComponentsFormatter new];
        dcf.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorPad;
        dcf.allowedUnits = NSCalendarUnitMinute | NSCalendarUnitSecond;
    }

    self.countdownLabel.stringValue = [dcf stringFromTimeInterval: secondsRemaining];
}

- (void)timerManagerTimerDidFinish: (TOCTimerManager *)manager
{
    [self updateUIForCountdownState: CountdownStateIsStopped];
    
    //bounce the dock icon until the app becomes active again
    [[NSApplication sharedApplication] requestUserAttention: NSCriticalRequest];
    
    [self showUserNotification];
}

#pragma mark - Actions

- (IBAction)stepperAction: (NSStepper *)sender
{
    NSInteger minutes = sender.integerValue;
    self.timerManager.minutes = minutes;
    self.minutesLabel.stringValue = [NSString stringWithFormat: @"%ld min", (long)minutes];
}

- (IBAction)startAction: (id)sender
{
    [self.timerManager startTimer];
    [self updateUIForCountdownState: CountdownStateIsCountingDown];
}

- (IBAction)stopAction: (id)sender
{
    [self.timerManager stopTimer];
    [self updateUIForCountdownState: CountdownStateIsStopped];
}

#pragma mark - Helpers

- (void)updateUIForCountdownState: (CountdownState)countdownState
{
    BOOL isStopped = countdownState == CountdownStateIsStopped;
    
    self.startButton.enabled = isStopped;
    self.stopButton.enabled = !isStopped;
    self.stepper.enabled = isStopped;
    self.minutesLabel.textColor = isStopped ? [NSColor whiteColor] : [NSColor grayColor];
    self.countdownLabel.textColor = isStopped ? [NSColor grayColor] : [NSColor whiteColor];
}

- (void)showUserNotification
{
    NSUserNotification *notification = [NSUserNotification new];
    notification.title = @"Timer Finished!";
    notification.informativeText = @"Enjoy your tea";
    notification.soundName = NSUserNotificationDefaultSoundName;
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification: notification];
}

@end

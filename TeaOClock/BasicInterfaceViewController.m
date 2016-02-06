//
//  BasicInterfaceViewController.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/21/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "BasicInterfaceViewController.h"

@interface BasicInterfaceViewController ()

@property (weak) IBOutlet NSTextField *minutesLabel;
@property (weak) IBOutlet NSTextField *countdownLabel;
@property (weak) IBOutlet NSStepper *stepper;
@property (weak) IBOutlet NSButton *startButton;
@property (weak) IBOutlet NSButton *stopButton;

@end

@implementation BasicInterfaceViewController

@synthesize delegate = _delegate;

#pragma mark - Interface View Controller

- (void)updateInterfaceForIntialStateWithMinutes: (NSInteger)minutes
{
    NSInteger seconds = minutes * 60;
    self.stepper.integerValue = minutes;
    
    [self updateCountdownLabelForSeconds: seconds];
    [self updateMinutesLabelForMinutes: minutes];
}

- (void)updateInterfaceForStateChanged: (TimerInterfaceState)interfaceState
{
    BOOL isStopped = (interfaceState == TimerInterfaceStateIsStopped);
    
    self.startButton.enabled = isStopped;
    self.stopButton.enabled = !isStopped;
    self.stepper.enabled = isStopped;
    self.minutesLabel.textColor = isStopped ? [NSColor whiteColor] : [NSColor grayColor];
    self.countdownLabel.textColor = isStopped ? [NSColor grayColor] : [NSColor whiteColor];
}

- (void)updateInterfaceForSecondsRemainingChanged: (NSInteger)secondsRemaining
{
    [self updateCountdownLabelForSeconds: secondsRemaining];
}

#pragma mark - Actions

- (IBAction)stepperAction: (NSStepper *)sender
{
    NSInteger minutes = sender.integerValue;
    [self.delegate interfaceController: self requestsSetInitialMinutes: minutes];
    [self updateMinutesLabelForMinutes: minutes];
}

- (IBAction)startButtonAction: (id)sender
{
    [self.delegate interfaceControllerRequestsStartTimer: self];
}

- (IBAction)stopButtonAction: (id)sender
{
    [self.delegate interfaceControllerRequestsStopTimer: self];
}

#pragma mark - Helpers

- (void)updateMinutesLabelForMinutes: (NSInteger)minutes
{
    self.minutesLabel.stringValue = [NSString stringWithFormat: @"%ld min", (long)minutes];
}

- (void)updateCountdownLabelForSeconds: (NSInteger)seconds
{
    static NSDateComponentsFormatter *dcf;
    if (!dcf)
    {
        dcf = [NSDateComponentsFormatter new];
        dcf.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorPad;
        dcf.allowedUnits = NSCalendarUnitMinute | NSCalendarUnitSecond;
    }
    
    self.countdownLabel.stringValue = [dcf stringFromTimeInterval: seconds];
}

@end

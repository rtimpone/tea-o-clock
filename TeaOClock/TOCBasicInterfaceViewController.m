//
//  TOCBasicInterfaceViewController.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/21/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "TOCBasicInterfaceViewController.h"

@interface TOCBasicInterfaceViewController ()

@property (weak) IBOutlet NSTextField *minutesLabel;
@property (weak) IBOutlet NSTextField *countdownLabel;
@property (weak) IBOutlet NSStepper *stepper;
@property (weak) IBOutlet NSButton *startButton;
@property (weak) IBOutlet NSButton *stopButton;

@end

@implementation TOCBasicInterfaceViewController

@synthesize delegate = _delegate;

#pragma mark - Interface View Controller

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
    static NSDateComponentsFormatter *dcf;
    if (!dcf)
    {
        dcf = [NSDateComponentsFormatter new];
        dcf.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorPad;
        dcf.allowedUnits = NSCalendarUnitMinute | NSCalendarUnitSecond;
    }
    
    self.countdownLabel.stringValue = [dcf stringFromTimeInterval: secondsRemaining];
}

#pragma mark - Actions

- (IBAction)stepperAction: (NSStepper *)sender
{
    NSInteger minutes = sender.integerValue;
    [self.delegate interfaceController: self requestsSetInitialMinutes: minutes];
    self.minutesLabel.stringValue = [NSString stringWithFormat: @"%ld min", (long)minutes];
}

- (IBAction)startButtonAction: (id)sender
{
    [self.delegate interfaceControllerRequestsStartTimer: self];
}

- (IBAction)stopButtonAction: (id)sender
{
    [self.delegate interfaceControllerRequestsStopTimer: self];
}

@end

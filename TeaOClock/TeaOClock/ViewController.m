//
//  ViewController.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/19/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak) IBOutlet NSTextField *minutesLabel;
@property (weak) IBOutlet NSTextField *countdownLabel;
@property (weak) IBOutlet NSStepper *stepper;
@property (weak) IBOutlet NSButton *startButton;
@property (weak) IBOutlet NSButton *stopButton;

@property (nonatomic) NSInteger minutes;
@property (nonatomic) NSInteger seconds;

@property (strong) NSTimer *timer;

@end

typedef NS_ENUM(NSUInteger, CountdownState) {
    CountdownStateIsCountingDown,
    CountdownStateIsStopped
};

#define DEFAULT_MINUTES 3

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.minutes = DEFAULT_MINUTES;
}

#pragma mark - Actions

- (IBAction)stepperAction: (NSStepper *)sender
{
    self.minutes = sender.integerValue;
}

- (IBAction)startAction: (id)sender
{
    [self updateUIForCountdownState: CountdownStateIsCountingDown];
    
    self.seconds = self.minutes * 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(decrementSeconds) userInfo: nil repeats: YES];
}

- (IBAction)stopAction: (id)sender
{
    [self stopTimer];
}

#pragma mark - Setters

- (void)setMinutes: (NSInteger)minutes
{
    _minutes = minutes;
    self.minutesLabel.stringValue = [NSString stringWithFormat: @"%ld min", (long)minutes];
}

- (void)setSeconds: (NSInteger)seconds
{
    _seconds = seconds;
    
    static NSDateComponentsFormatter *dcf;
    if (!dcf)
    {
        dcf = [NSDateComponentsFormatter new];
        dcf.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorPad;
        dcf.allowedUnits = NSCalendarUnitMinute | NSCalendarUnitSecond;
    }
    
    self.countdownLabel.stringValue = [dcf stringFromTimeInterval: seconds];
}

#pragma mark - Helpers

- (void)decrementSeconds
{
    self.seconds = self.seconds - 1;
    if (self.seconds == 0)
    {
        [self stopTimer];
    }
}

- (void)stopTimer
{
    [self updateUIForCountdownState: CountdownStateIsStopped];
    [self.timer invalidate];
}

- (void)updateUIForCountdownState: (CountdownState)countdownState
{
    BOOL isStopped = countdownState == CountdownStateIsStopped;
    
    self.startButton.enabled = isStopped;
    self.stopButton.enabled = !isStopped;
    self.stepper.enabled = isStopped;
    self.minutesLabel.textColor = isStopped ? [NSColor blackColor] : [NSColor grayColor];
    self.countdownLabel.textColor = isStopped ? [NSColor grayColor] : [NSColor blackColor];
}

@end

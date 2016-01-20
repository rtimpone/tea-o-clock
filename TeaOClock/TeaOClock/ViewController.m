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

@end

#define DEFAULT_MINUTES 3

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.stepper setIntegerValue: DEFAULT_MINUTES];
    self.minutes = DEFAULT_MINUTES;
}

#pragma mark - Actions

- (IBAction)stepperAction: (NSStepper *)sender
{
    self.minutes = sender.integerValue;
}

- (IBAction)startAction: (id)sender
{
    self.startButton.enabled = NO;
    self.stopButton.enabled = YES;
    
    //start timer
}

- (IBAction)stopAction: (id)sender
{
    self.startButton.enabled = YES;
    self.stopButton.enabled = NO;
    
    //reset timer
}

#pragma mark - Setters

- (void)setMinutes: (NSInteger)minutes
{
    _minutes = minutes;
    self.minutesLabel.stringValue = [NSString stringWithFormat: @"Minutes: %ld", (long)self.minutes];
}


@end

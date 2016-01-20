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

#pragma mark - Setters

- (void)setMinutes: (NSInteger)minutes
{
    _minutes = minutes;
    
    NSString *intString = [NSString stringWithFormat: @"Minutes: %ld", (long)self.minutes];
    [self.minutesLabel setStringValue: intString];
}


@end

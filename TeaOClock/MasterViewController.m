//
//  MasterViewController.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/19/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "InterfaceViewController.h"
#import "MasterViewController.h"
#import "NotificationManager.h"
#import "TimerManager.h"
#import "UserPreferencesManager.h"

@interface MasterViewController () <InterfaceViewControllerDelegate, TimerManagerDelegate>

@property (strong) NSViewController <InterfaceViewController> *interfaceController;
@property (strong) IBOutlet NotificationManager *notificationManager;
@property (strong) IBOutlet TimerManager *timerManager;

@end

NSString * const kDefaultInterfaceControllerEmbedSegueIdentifier = @"DefaultInterfaceControllerEmbedSegueIdentifier";
NSString * const kLightInterfaceStoryboardIdentifier = @"kLightInterfaceStoryboardIdentifier";
NSString * const kDarkInterfaceStoryboardIdentifier = @"kDarkInterfaceStoryboardIdentifier";

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger minutes = [UserPreferencesManager userDefinedMinutes];
    [self.interfaceController updateInterfaceForIntialStateWithMinutes: minutes];
}

- (void)prepareForSegue: (NSStoryboardSegue *)segue sender: (id)sender
{
    if ([segue.identifier isEqualToString: kDefaultInterfaceControllerEmbedSegueIdentifier])
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
    [UserPreferencesManager setUserDefintedMinutes: minutes];
}

#pragma mark - Timer Manager Delegate

- (void)timerManager: (TimerManager *)manager secondsRemainingDidChange: (NSInteger)secondsRemaining
{
    [self.interfaceController updateInterfaceForSecondsRemainingChanged: secondsRemaining];
}

- (void)timerManagerTimerDidFinish: (TimerManager *)manager
{
    [self.interfaceController updateInterfaceForStateChanged: TimerInterfaceStateIsStopped];
    
    [self.notificationManager bounceDockBarIcon];
    [self.notificationManager showTimerFinishedUserNotification];
}

#pragma mark - Menu Actions

- (IBAction)lightAction: (NSMenuItem *)sender
{
    [self selectMenuItem: sender];
    [self displayInterfaceWithIdentifier: kLightInterfaceStoryboardIdentifier];
}

- (IBAction)darkAction: (NSMenuItem *)sender
{
    [self selectMenuItem: sender];
    [self displayInterfaceWithIdentifier: kDarkInterfaceStoryboardIdentifier];
}

#pragma mark - Helpers

- (void)displayInterfaceWithIdentifier: (NSString *)identifier
{
    [self.interfaceController.view removeFromSuperview];
    [self.interfaceController removeFromParentViewController];
    
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName: @"Main" bundle: nil];
    NSViewController <InterfaceViewController> *vc = [storyboard instantiateControllerWithIdentifier: identifier];
    
    self.interfaceController = vc;
    vc.delegate = self;
    
    NSInteger minutes = [UserPreferencesManager userDefinedMinutes];
    [vc updateInterfaceForIntialStateWithMinutes: minutes];
    
    [self.view addSubview: vc.view];
    [self addChildViewController: vc];
}

- (void)selectMenuItem: (NSMenuItem *)selectedItem
{
    NSMenu *menu = (NSMenu *)[[[[NSApplication sharedApplication] mainMenu] itemAtIndex: 1] submenu];
    for (NSMenuItem *item in menu.itemArray)
    {
        item.state = (item == selectedItem);
    }
}

@end

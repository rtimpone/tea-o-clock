//
//  MasterViewController.m
//  TeaOClock
//
//  Created by Rob Timpone on 1/19/16.
//  Copyright © 2016 Rob Timpone. All rights reserved.
//

#import "InterfaceViewController.h"
#import "MasterViewController.h"
#import "MenuItemManager.h"
#import "NotificationManager.h"
#import "TimerManager.h"
#import "UserPreferencesManager.h"

@interface MasterViewController () <InterfaceViewControllerDelegate, MenuItemManagerDelegate, TimerManagerDelegate>

@property (strong) NSViewController <InterfaceViewController> *interfaceController;
@property (strong) IBOutlet MenuItemManager *menuItemManager;
@property (strong) IBOutlet NotificationManager *notificationManager;
@property (strong) IBOutlet TimerManager *timerManager;

@end

NSString * const kLightInterfaceStoryboardIdentifier = @"kLightInterfaceStoryboardIdentifier";
NSString * const kDarkInterfaceStoryboardIdentifier = @"kDarkInterfaceStoryboardIdentifier";

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InterfaceType lastInterfaceUsed = [UserPreferencesManager lastInterfaceTypeUsed];
    [self displayInterfaceForInterfaceType: lastInterfaceUsed];
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

#pragma mark - Menu Item Manager Delegate

- (void)menuItemManager: (MenuItemManager *)manager didSelectInterfaceType: (InterfaceType)type
{
    [UserPreferencesManager setLastInterfaceTypeUsed: type];
    [self displayInterfaceForInterfaceType: type];
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

#pragma mark - Actions

//the manu item manager isn't in the responer chain and can't link its actions to the menu items directly
- (IBAction)menuItemAction: (NSMenuItem *)sender
{
    [self.timerManager stopTimer];
    [self.menuItemManager handleSelectedMenuItem: sender];
}

#pragma mark - Helpers

- (void)displayInterfaceForInterfaceType: (InterfaceType)type
{
    NSString *identifier = [self storyboardIdentifierForInterfaceType: type];
    
    [self.interfaceController.view removeFromSuperview];
    [self.interfaceController removeFromParentViewController];
    
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName: @"Main" bundle: nil];
    NSViewController <InterfaceViewController> *vc = [storyboard instantiateControllerWithIdentifier: identifier];
    
    self.interfaceController = vc;
    vc.delegate = self;
    
    [self.view addSubview: vc.view];
    [self addChildViewController: vc];
    
    NSInteger minutes = [UserPreferencesManager userDefinedMinutes];
    [vc updateInterfaceForIntialStateWithMinutes: minutes];
}

- (NSString *)storyboardIdentifierForInterfaceType: (InterfaceType)type
{
    if (type == InterfaceTypeLight)
    {
        return kLightInterfaceStoryboardIdentifier;
    }
    else if (type == InterfaceTypeDark)
    {
        return kDarkInterfaceStoryboardIdentifier;
    }
    
    return nil;
}

@end

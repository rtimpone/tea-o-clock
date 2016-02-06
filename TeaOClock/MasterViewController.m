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

NSString * const kDefaultInterfaceControllerEmbedSegueIdentifier = @"DefaultInterfaceControllerEmbedSegueIdentifier";
NSString * const kLightInterfaceStoryboardIdentifier = @"kLightInterfaceStoryboardIdentifier";
NSString * const kDarkInterfaceStoryboardIdentifier = @"kDarkInterfaceStoryboardIdentifier";

@implementation MasterViewController

- (void)prepareForSegue: (NSStoryboardSegue *)segue sender: (id)sender
{
    //this embed segue gets called before viewDidLoad
    if ([segue.identifier isEqualToString: kDefaultInterfaceControllerEmbedSegueIdentifier])
    {
        self.interfaceController = segue.destinationController;
        self.interfaceController.delegate = self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger minutes = [UserPreferencesManager userDefinedMinutes];
    [self.interfaceController updateInterfaceForIntialStateWithMinutes: minutes];
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
    if (type == InterfaceTypeLight)
    {
        [self displayInterfaceWithIdentifier: kLightInterfaceStoryboardIdentifier];
    }
    else if (type == InterfaceTypeDark)
    {
        [self displayInterfaceWithIdentifier: kDarkInterfaceStoryboardIdentifier];
    }
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

- (void)displayInterfaceWithIdentifier: (NSString *)identifier
{
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

@end

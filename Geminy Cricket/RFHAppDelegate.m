//
//  RFHAppDelegate.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 4/12/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHAppDelegate.h"
#import "RFHViewController.h"
#import "RFHHomeScreenViewController.h"

@interface RFHAppDelegate () <AVAudioPlayerDelegate>


@end

@implementation RFHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithRed:.8392156 green:.8392156 blue:.8392156 alpha:1.0];
    [self initializeDataController];
    return YES;
}

#pragma mark - App Launch

- (void)initializeDataController {
    RFHDataController *dataController = [[RFHDataController alloc] init];
    self.dataController = dataController;
}

- (void)setupUI {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    RFHHomeScreenViewController *homeScreen = [[RFHHomeScreenViewController alloc] init];
    self.window.rootViewController = homeScreen;
    
    self.homeScreenViewController = homeScreen;
    self.statsViewController = [[RFHStatsViewController alloc] init];
    self.gameHistoryController = [[RFHGameHistoryController alloc] init];
    self.creatorInfoController = [[RFHCreatorInfoViewController alloc] init];
    self.navigationGameHistoryController = [[UINavigationController alloc] initWithRootViewController:self.gameHistoryController];
    self.navigationStatsController = [[UINavigationController alloc] initWithRootViewController:self.statsViewController];
    
    self.navigationCreatorInfoController = [[UINavigationController alloc] initWithRootViewController:self.creatorInfoController];
    self.rulesViewController = [[RFHRulesViewController alloc] init];
    
    //initialize sound
    
    [self playMusic];
    
    self.window.backgroundColor = [UIColor colorWithRed:.8392156 green:.8392156 blue:.8392156 alpha:1.0];
    [self.window makeKeyAndVisible];
}

#pragma  mark - Music Controls

-(void)playMusic
{
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"geminyAudioSwing" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.audioPlayer.numberOfLoops = -1;
    self.audioPlayer.volume = 0.6;
    [self.audioPlayer play];
    self.audioIsPlaying = YES;

}


#pragma  mark - Other

-(void)returnHome
{
    self.window.rootViewController = self.homeScreenViewController;
}

-(void)resetGame {
    RFHViewController *rvc = [[RFHViewController alloc] init];
    self.window.rootViewController = rvc;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

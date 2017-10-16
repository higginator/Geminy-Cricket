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
#import "LaunchVC.h"

@interface RFHAppDelegate () <AVAudioPlayerDelegate>


@end

@implementation RFHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithRed:.8392156 green:.8392156 blue:.8392156 alpha:1.0];
    LaunchVC *launchVC = [[LaunchVC alloc] init];

    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    [self initializeDataController];
    return YES;
}

#pragma mark - App Launch

- (void)initializeDataController {
    RFHDataController *dataController = [[RFHDataController alloc] init];
    self.dataController = dataController;
}

- (void)setupUI {
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


@end

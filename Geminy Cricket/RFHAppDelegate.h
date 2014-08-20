//
//  RFHAppDelegate.h
//  Geminy Cricket
//
//  Created by Ryan Higgins on 4/12/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFHStatsViewController.h"
#import "RFHHomeScreenViewController.h"
#import "RFHGameHistoryController.h"
#import "RFHRulesViewController.h"
#import "RFHCreatorInfoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface RFHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RFHStatsViewController *statsViewController;
@property (strong, nonatomic) RFHHomeScreenViewController *homeScreenViewController;
@property (strong, nonatomic) RFHGameHistoryController *gameHistoryController;
@property (nonatomic, strong) RFHCreatorInfoViewController *creatorInfoController;
@property (strong, nonatomic) UINavigationController *navigationGameHistoryController;
@property (strong, nonatomic) UINavigationController *navigationStatsController;
@property (strong, nonatomic) UINavigationController *navigationCreatorInfoController;
@property (nonatomic, strong) RFHRulesViewController *rulesViewController;

@property (nonatomic) NSUInteger wins;
@property (nonatomic) NSUInteger losses;
@property (nonatomic) NSUInteger flawlessVictories;
@property (nonatomic) NSUInteger winStreak;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL audioIsPlaying;

@property (nonatomic) UIView *fadedView;

-(void)resetGame;
-(void)returnHome;

@end

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

@interface RFHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RFHStatsViewController *statsViewController;
@property (strong, nonatomic) RFHHomeScreenViewController *homeScreenViewController;
@property (strong, nonatomic) RFHGameHistoryController *gameHistoryController;
@property (strong, nonatomic) UINavigationController *navigationGameHistoryController;
@property (strong, nonatomic) UINavigationController *navigationStatsController;

@property (nonatomic) NSUInteger wins;
@property (nonatomic) NSUInteger losses;
@property (nonatomic) NSUInteger bestWin;
@property (nonatomic) NSUInteger worstLoss;
@property (nonatomic) NSUInteger flawlessVictories;


-(void)resetGame;
-(void)returnHome;

@end

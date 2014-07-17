//
//  RFHHomeScreenViewController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 7/10/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHHomeScreenViewController.h"
#import "RFHViewController.h"
#import "RFHStatsViewController.h"
#import "RFHAppDelegate.h"

@interface RFHHomeScreenViewController ()


@end

@implementation RFHHomeScreenViewController

- (IBAction)startGame:(id)sender {
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    RFHViewController *rvc = [[RFHViewController alloc] init];
    topWindow.rootViewController = rvc;
    
    self.gameViewController = rvc;
}

- (IBAction)showStats:(id)sender {
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = appDelegate.navigationStatsController;
}

- (IBAction)showHistory:(id)sender {
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = appDelegate.navigationGameHistoryController;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


@end

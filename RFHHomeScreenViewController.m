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

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *statsButton;
@property (strong, nonatomic) IBOutlet UIButton *historyButton;

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
    self.view.backgroundColor = [UIColor colorWithRed:.8392156 green:.8392156 blue:.8392156 alpha:1.0];
    self.titleLabel.textColor = [UIColor colorWithRed:.760784 green:.1019607 blue:.2666667 alpha:1.0];
    self.playButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.playButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:150];
    self.playButton.titleLabel.textColor = [UIColor whiteColor];
    self.playButton.titleLabel.shadowColor = [UIColor blackColor];
    
    self.statsButton.titleLabel.textColor = [UIColor blackColor];
    self.statsButton.titleLabel.shadowColor = [UIColor whiteColor];
    self.historyButton.titleLabel.textColor = [UIColor blackColor];
    self.historyButton.titleLabel.shadowColor = [UIColor whiteColor];
}


@end

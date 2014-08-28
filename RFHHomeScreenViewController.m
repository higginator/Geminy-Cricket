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
@property (strong, nonatomic) IBOutlet UIButton *creatorInfoButton;
@property (strong, nonatomic) IBOutlet UIButton *musicInfoButton;
@property (strong, nonatomic) IBOutlet UIButton *additionalInfoButton;
@property (strong, nonatomic) IBOutlet UIButton *rulesButton;

@end

@implementation RFHHomeScreenViewController

- (IBAction)startGame:(id)sender {
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    RFHViewController *rvc = [[RFHViewController alloc] init];
    topWindow.rootViewController = rvc;
    self.gameViewController = rvc;
}
- (IBAction)showRules:(id)sender {
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = [[RFHRulesViewController alloc] init];
    
}

- (IBAction)showStats:(id)sender {
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = appDelegate.navigationStatsController;
}

- (IBAction)showHistory:(id)sender {
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = appDelegate.navigationGameHistoryController;

}
- (IBAction)moreControls:(id)sender {
    if ([[sender currentImage] isEqual:[UIImage imageNamed:@"arrowBegin.png"]]) {
        [sender setImage:[UIImage imageNamed:@"arrowInfo.png"] forState:UIControlStateNormal];
        self.creatorInfoButton.hidden = NO;
        self.musicInfoButton.hidden = NO;
    } else {
        [sender setImage:[UIImage imageNamed:@"arrowBegin.png"]forState:UIControlStateNormal];
        self.creatorInfoButton.hidden = YES;
        self.musicInfoButton.hidden = YES;
    }
}

- (IBAction)toggleMusic:(id)sender {
    RFHAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (appDelegate.audioIsPlaying) {
        [appDelegate.audioPlayer stop];
        appDelegate.audioIsPlaying = NO;
        [sender setImage:[UIImage imageNamed:@"MusicFinalCancel.png"] forState:UIControlStateNormal];
    } else {
        appDelegate.audioPlayer.numberOfLoops = -1;
        [appDelegate.audioPlayer play];
        appDelegate.audioIsPlaying = YES;
        [sender setImage:[UIImage imageNamed:@"MusicFinal.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)showCreatorInfo:(id)sender {
    RFHAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = appDelegate.navigationCreatorInfoController;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient.png"]];
    self.titleLabel.textColor = [UIColor colorWithRed:.341176 green:.070588 blue:.807843 alpha:1.0];
    self.titleLabel.font = [UIFont fontWithName:@"ChalkDuster" size:29];
    self.playButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.playButton.titleLabel.font = [UIFont fontWithName:@"ChalkDuster" size:100];
    self.playButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.playButton.titleLabel.textColor = [UIColor whiteColor];
    //self.playButton.titleLabel.shadowColor = [UIColor blackColor];
    
    UIFont *subtitleFont = [UIFont fontWithName:@"Chalkduster" size:15];
    self.statsButton.titleLabel.font = subtitleFont;
    self.statsButton.titleLabel.textColor = [UIColor blackColor];
    self.historyButton.titleLabel.font = subtitleFont;
    self.historyButton.titleLabel.textColor = [UIColor blackColor];
    self.rulesButton.titleLabel.font = subtitleFont;
    self.rulesButton.titleLabel.textColor = [UIColor blackColor];
    
    [self.additionalInfoButton setImage:[UIImage imageNamed:@"MoreInfo.png"] forState:UIControlStateNormal];
    self.creatorInfoButton.hidden = YES;
    self.musicInfoButton.hidden = YES;
}


@end

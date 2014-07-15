//
//  RFHStatsViewController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 7/14/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHStatsViewController.h"
#import "RFHAppDelegate.h"

@interface RFHStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *winsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lossesLabel;
@property (weak, nonatomic) IBOutlet UILabel *marginOfVictoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *marginOfDefeatLabel;

@end

@implementation RFHStatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.winsLabel.text = [NSString stringWithFormat:@"Wins: %lu", appDelegate.wins];
    self.lossesLabel.text = [NSString stringWithFormat:@"Losses: %lu", appDelegate.losses];
    self.marginOfVictoryLabel.text = [NSString stringWithFormat:@"Greatest Victory: %lu", appDelegate.bestWin];
    self.marginOfDefeatLabel.text = [NSString stringWithFormat:@"Greatest Defeat: %lu", appDelegate.worstLoss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
@property (weak, nonatomic) IBOutlet UILabel *flawlessVictoriesLabel;

@end

@implementation RFHStatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"STATS";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(returnHome:)];
        self.navigationItem.leftBarButtonItem = bbi;
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.winsLabel.text = [NSString stringWithFormat:@"Wins: %lu", (unsigned long)appDelegate.wins];
    self.lossesLabel.text = [NSString stringWithFormat:@"Losses: %lu", (unsigned long)appDelegate.losses];
    self.marginOfVictoryLabel.text = [NSString stringWithFormat:@"Greatest Victory: %lu", (unsigned long)appDelegate.bestWin];
    self.marginOfDefeatLabel.text = [NSString stringWithFormat:@"Greatest Defeat: %lu", (unsigned long)appDelegate.worstLoss];
    self.flawlessVictoriesLabel.text = [NSString stringWithFormat:@"Flawless Victories: %lu", (unsigned long)appDelegate.flawlessVictories];
    
}

- (IBAction)returnHome:(id)sender {
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate performSelector:@selector(returnHome)];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient7.jpg"]];
}

@end

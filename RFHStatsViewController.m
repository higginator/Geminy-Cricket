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
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet UILabel *flawlessVictoriesLabel;
@property (strong, nonatomic) IBOutlet UILabel *winStreakLabel;
@property (strong, nonatomic) IBOutlet UILabel *longestWinStreakLabel;

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
    
    //self.winsLabel.text = [NSString stringWithFormat:@"Wins: %lu", (unsigned long)appDelegate.wins];
    NSMutableAttributedString *record = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu - %lu", (unsigned long)appDelegate.stats.wins, (unsigned long) appDelegate.stats.losses]];
    UIFont *font = [UIFont fontWithName:@"Chalkduster" size:45];
    [record addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, record.length)];
    [record addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, record.length)];
    self.recordLabel.attributedText = record;
    
    NSMutableAttributedString *flawlessVictories = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Flawless Victories: %lu",(unsigned long)appDelegate.stats.flawlessVictories]];
    UIFont *font2 = [UIFont fontWithName:@"Chalkduster" size:20];
    [flawlessVictories addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(0, flawlessVictories.length)];
    [flawlessVictories addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, flawlessVictories.length)];
    self.flawlessVictoriesLabel.attributedText = flawlessVictories;
    
    NSMutableAttributedString *winStreak = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Current Win Streak: %lu",(unsigned long)appDelegate.stats.winStreak]];
    [winStreak addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(0, winStreak.length)];
    [winStreak addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, winStreak.length)];
    self.winStreakLabel.attributedText = winStreak;
    
    NSMutableAttributedString *longestWinStreak = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Best Win Streak: %lu",(unsigned long)appDelegate.stats.longestWinStreak]];
    [longestWinStreak addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(0, longestWinStreak.length)];
    [longestWinStreak addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, longestWinStreak.length)];
    self.longestWinStreakLabel.attributedText = longestWinStreak;
    
}

- (IBAction)returnHome:(id)sender {
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate performSelector:@selector(returnHome)];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient.png"]];
}

@end

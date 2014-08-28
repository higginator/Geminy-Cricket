//
//  RFHCreatorInfoViewController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 8/10/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHCreatorInfoViewController.h"
#import "RFHAppDelegate.h"

@interface RFHCreatorInfoViewController ()
@property (strong, nonatomic) IBOutlet UILabel *ryanHigginsLabel;
@property (strong, nonatomic) IBOutlet UILabel *ryanHigginsTagLabel;
@property (strong, nonatomic) IBOutlet UILabel *gabeDizonLabel;
@property (strong, nonatomic) IBOutlet UILabel *gabeDizonTagLabel;
@property (strong, nonatomic) IBOutlet UILabel *higginatorLabel;

@end

@implementation RFHCreatorInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"SQUAD";
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(returnHome:)];
        self.navigationItem.leftBarButtonItem = bbi;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.navigationController.navigationBar.translucent = YES;
    }
    return self;
}

-(void)returnHome:(id)sender
{
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate performSelector:@selector(returnHome)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient.png"]];
    
    NSMutableAttributedString *ryanHiggins = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Ryan Higgins"]];
    UIFont *font = [UIFont fontWithName:@"Chalkduster" size:35];
    [ryanHiggins addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, ryanHiggins.length)];
    [ryanHiggins addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, ryanHiggins.length)];
    self.ryanHigginsLabel.attributedText = ryanHiggins;
    
    NSMutableAttributedString *ryanHigginsTag = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Creator"]];
    UIFont *subFont = [UIFont fontWithName:@"Chalkduster" size:20];
    [ryanHigginsTag addAttribute:NSFontAttributeName value:subFont range:NSMakeRange(0, ryanHigginsTag.length)];
    [ryanHigginsTag addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, ryanHigginsTag.length)];
    self.ryanHigginsTagLabel.attributedText = ryanHigginsTag;
    
    NSMutableAttributedString *higginator = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"www.higginator.com"]];
    [higginator addAttribute:NSFontAttributeName value:subFont range:NSMakeRange(0, higginator.length)];
    [higginator addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, higginator.length)];
    self.higginatorLabel.attributedText = higginator;
    
    
    NSMutableAttributedString *gabeDizon = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Gabe Dizon"]];
    [gabeDizon addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, gabeDizon.length)];
    [gabeDizon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, gabeDizon.length)];
    self.gabeDizonLabel.attributedText = gabeDizon;
    
    NSMutableAttributedString *gabeDizonTag = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Gem Design"]];
    [gabeDizonTag addAttribute:NSFontAttributeName value:subFont range:NSMakeRange(0, gabeDizonTag.length)];
    [gabeDizonTag addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, gabeDizonTag.length)];
    self.gabeDizonTagLabel.attributedText = gabeDizonTag;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

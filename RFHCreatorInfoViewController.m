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

@end

@implementation RFHCreatorInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"CREATORS";
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(returnHome:)];
        self.navigationItem.leftBarButtonItem = bbi;
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

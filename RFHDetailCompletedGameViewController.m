//
//  RFHDetailCompletedGameViewController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 7/15/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHDetailCompletedGameViewController.h"

@interface RFHDetailCompletedGameViewController ()

@property (nonatomic, weak) RFHCompletedGame *game;

@end

@implementation RFHDetailCompletedGameViewController

-(instancetype)initWithGame:(RFHCompletedGame *)game
{
    if (self = [super init]) {
        _game = game;
    }
    return self;
}

-(instancetype)init
{
    return [self initWithGame:nil];
}

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

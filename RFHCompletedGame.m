//
//  RFHCompletedGame.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 7/15/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHCompletedGame.h"

@implementation RFHCompletedGame

-(instancetype)init
{
    if (self = [super init]) {
        _moveOrder = [[NSMutableArray alloc] init];
        _outcome = [NSString stringWithFormat:@"Undetermined"];
        _humanGemHand = [[NSMutableArray alloc] init];
        _human = [[RFHHumanPlayer alloc] init];
        _robotGemHand = [[NSMutableArray alloc] init];
        _robot = [[RFHRobotPlayer alloc] init];
        _humanVictory = NO;
    }
    return self;
}

@end

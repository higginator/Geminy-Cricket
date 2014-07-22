//
//  RFHCompletedGame.h
//  Geminy Cricket
//
//  Created by Ryan Higgins on 7/15/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFHHumanPlayer.h"
#import "RFHRobotPlayer.h"

@interface RFHCompletedGame : NSObject

@property (nonatomic, strong) NSMutableArray *moveOrder;
@property (nonatomic, strong) NSString *outcome;
@property (nonatomic, strong) NSMutableArray *humanGemHand;
@property (nonatomic, strong) RFHHumanPlayer *human;
@property (nonatomic, strong) NSMutableArray *robotGemHand;
@property (nonatomic, strong) RFHRobotPlayer *robot;

@end

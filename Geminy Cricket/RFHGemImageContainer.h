//
//  RFHGemImageContainer.h
//  Geminy Cricket
//
//  Created by Ryan Higgins on 4/13/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFHGemObject.h"
#import "RFHPlayer.h"

@interface RFHGemImageContainer : NSObject

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) CGPoint gemOriginalCenter;
@property (nonatomic) RFHGemObject *gem;
@property (nonatomic) RFHPlayer *owner;
@property (nonatomic) BOOL onBoard;

-(instancetype)initRobotGemContainer:(RFHGemObject *)gem Player:(RFHPlayer *)robot onBoard:(BOOL)onBoard;

@end

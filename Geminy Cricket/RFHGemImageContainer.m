//
//  RFHGemImageContainer.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 4/13/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHGemImageContainer.h"

@implementation RFHGemImageContainer


-(instancetype)initRobotGemContainer:(RFHGemObject *)gem Player:(RFHPlayer *)robot onBoard:(BOOL)onBoard
{
    if (self = [super init]) {
        _gem = gem;
        _owner = robot;
        _onBoard = onBoard;
        _gemOriginalCenter = CGPointMake(0, 0);
        _imageView = [[UIImageView alloc] init];
        //_imageView.image = [UIImage imageNamed:@"Chipped_Ruby.png"];
    }
    return self;
}

@end

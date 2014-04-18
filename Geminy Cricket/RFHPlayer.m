//
//  RFHPlayer.m
//  Element
//
//  Created by Ryan Higgins on 4/12/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHPlayer.h"

@implementation RFHPlayer

-(instancetype)initWithName:(NSString *)name Color:(UIColor *)color
{
    if (self = [super init]) {
        _name = name;
        _color = color;
    }
    return self;
}

-(instancetype)init
{
    return [self initWithName:@"Unknown" Color:[UIColor grayColor]];
}

@end

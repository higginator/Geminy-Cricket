//
//  RFHGemObject.m
//  Element
//
//  Created by Ryan Higgins on 4/12/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHGemObject.h"

@implementation RFHGemObject


-(NSString *)description {
    return [NSString stringWithFormat:@"%@ gem with value %lx", self.color, (long)self.value];
}

-(instancetype)initWithColor:(UIColor *)color Value:(NSInteger)n {
    if (self = [super init]) {
        _value = n;
        _color = color;
        NSString *imageName = [NSString stringWithFormat:@"GemLevel%ld.png", n];
        NSLog(@"image name is %@", imageName);
        _gemImage = [UIImage imageNamed:imageName];
    }
    return self;
}


-(instancetype)init {
    return [self initWithColor:[UIColor grayColor] Value:0];
}

+(instancetype)randomGem {
    // colors is a a random color between Red, Blue, Green, and Yellow
    // value is a random value 1-9
    NSArray *colors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor purpleColor]];
    int colorsIndex = arc4random() % [colors count];
    int val = 0;
    while (val == 0) {
        val = arc4random() % 6;
    }
    
    UIColor *color = colors[colorsIndex];
    NSLog(@"the val is %d", val);
    return [[self alloc] initWithColor:color Value:val];
}
@end

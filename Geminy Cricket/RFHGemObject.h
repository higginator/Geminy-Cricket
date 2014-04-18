//
//  RFHGemObject.h
//  Element
//
//  Created by Ryan Higgins on 4/12/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFHGemObject : NSObject

@property (nonatomic) NSInteger value;
@property (nonatomic, copy) NSString *color;
//implement images later
@property (nonatomic) UIImage *gemImage;
//@property (nonatomic) CGPoint gemOriginalCenter;
// The designated initializer
-(instancetype)initWithColor:(NSString *)color Value:(NSInteger)n;
+(instancetype)randomGem;

@end

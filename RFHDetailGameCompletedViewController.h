//
//  RFHDetailGameCompletedViewController.h
//  Geminy Cricket
//
//  Created by Ryan Higgins on 7/21/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFHCompletedGame.h"

@interface RFHDetailGameCompletedViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

-(instancetype)initWithGame:(RFHCompletedGame *)game;

@end

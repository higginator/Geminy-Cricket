//
//  RFHViewController.h
//  Geminy Cricket
//
//  Created by Ryan Higgins on 4/12/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RFHGemImageContainer;

@interface RFHViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) RFHGemImageContainer *gemOne;
@property (nonatomic) RFHGemImageContainer *gemTwo;
@property (nonatomic) RFHGemImageContainer *gemThree;
@property (nonatomic) RFHGemImageContainer *gemFour;
@property (nonatomic) RFHGemImageContainer *gemFive;
@property (nonatomic) RFHGemImageContainer *gemSix;

@property IBOutlet UIButton *resetButton;

@end

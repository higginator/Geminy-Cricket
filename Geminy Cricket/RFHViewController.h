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
@property (nonatomic) UILabel *scoreLabel;
@property (nonatomic) UILabel *humanNameLabel;
@property (nonatomic) UILabel *robotNameLabel;
@property (nonatomic) UILabel *humanScoreLabel;
@property (nonatomic) UILabel *robotScoreLabel;
@property (nonatomic) RFHGemImageContainer *gemOne;
@property (nonatomic) RFHGemImageContainer *gemTwo;
@property (nonatomic) RFHGemImageContainer *gemThree;
@property (nonatomic) RFHGemImageContainer *gemFour;
@property (nonatomic) RFHGemImageContainer *gemFive;
@property (nonatomic) RFHGemImageContainer *gemSix;

@property (nonatomic) NSMutableArray *moveOrder;

@end

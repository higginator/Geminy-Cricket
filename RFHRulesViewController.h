//
//  RFHInstructionsViewController.h
//  Geminy Cricket
//
//  Created by Ryan Higgins on 8/19/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHViewController.h"

@interface RFHRulesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
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

@property (nonatomic) UILabel *intro;
@property (nonatomic) UILabel *introLineTwo;
@property (nonatomic) UILabel *introLineThree;
@property (nonatomic) UIButton *nextButton;

@property (nonatomic) NSMutableArray *moveOrder;

@end

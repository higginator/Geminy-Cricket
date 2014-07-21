//
//  RFHDetailGameCompletedViewController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 7/21/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHDetailGameCompletedViewController.h"

@interface RFHDetailGameCompletedViewController ()

@property (nonatomic, weak) RFHCompletedGame *game;
@property (nonatomic, strong) UICollectionView *completedGameCollectionView;
@property (nonatomic) NSInteger boardOffsetY, boardOffsetX;

@end

@implementation RFHDetailGameCompletedViewController


-(instancetype)initWithGame:(RFHCompletedGame *)game
{
    if (self = [super init]) {
        _game = game;
        
        self.boardOffsetX = 10;
        int y;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            //iPhone 5 screen
            self.boardOffsetY = 86;
            y = 498;
        } else {
            //iPhone 4/4s screen
            self.boardOffsetY = 26 + 44;
            y = 418;
        }
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _completedGameCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.boardOffsetX, self.boardOffsetY, 300, 375)
                                                 collectionViewLayout:layout];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(instancetype)init
{
    return [self initWithGame:nil];
}


-(void)loadView
{
    [super loadView];
    
    self.completedGameCollectionView.dataSource = self;
    self.completedGameCollectionView.delegate = self;
    [self.completedGameCollectionView.layer setCornerRadius:10.0f];
    [self.completedGameCollectionView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.completedGameCollectionView.layer setBorderWidth:1.0f];
    [self.completedGameCollectionView registerClass:[UICollectionViewCell class]
                     forCellWithReuseIdentifier:@"aBoardCell"];
    self.completedGameCollectionView.backgroundColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.completedGameCollectionView];
}



#pragma mark - Collection View Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //create a cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aBoardCell"
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:.917647 green:.831372 blue:.341176 alpha:1.0];
    
    
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 125);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}




@end

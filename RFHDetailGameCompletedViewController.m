//
//  RFHDetailGameCompletedViewController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 7/21/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHDetailGameCompletedViewController.h"
#import "RFHGemImageContainer.h"

@interface RFHDetailGameCompletedViewController ()

@property (nonatomic, weak) RFHCompletedGame *game;
@property (nonatomic, strong) UICollectionView *completedGameCollectionView;
//@property (nonatomic, strong)
@property (nonatomic) NSInteger boardOffsetY, boardOffsetX, y, boardWidth, boardHeight;
@property (nonatomic, strong) RFHGemImageContainer *gemOne, *gemTwo, *gemThree, *gemFour, *gemFive, *gemSix;
@property (nonatomic, strong) RFHGemImageContainer *robotGemOne, *robotGemTwo, *robotGemThree, *robotGemFour, *robotGemFive, *robotGemSix;
@property (nonatomic) BOOL iPhone4Inch;

@end

@implementation RFHDetailGameCompletedViewController


-(instancetype)initWithGame:(RFHCompletedGame *)game
{
    if (self = [super init]) {
        _game = game;
        
        self.boardOffsetX = 10;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            //iPhone 5 screen
            self.boardOffsetY = 86 + 50;
            self.y = 498 - 52;
            self.iPhone4Inch = NO;
            self.boardWidth = 300;
            self.boardHeight = 270;
        } else {
            //iPhone 4/4s screen
            self.boardOffsetY = 26 + 104;
            self.y = 418;
            self.boardWidth = 300;
            self.boardHeight = 210;
            self.iPhone4Inch = YES;
        }
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _completedGameCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.boardOffsetX, self.boardOffsetY, self.boardWidth, self.boardHeight)
                                                 collectionViewLayout:layout];
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawBoard];
    [self drawHumanHand];
    [self drawRobotHand];
}

#pragma mark - View Drawing Methods

-(void)drawBoard
{
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

-(void)drawHumanHand
{
    NSInteger yStart;
    if (self.iPhone4Inch) {
        yStart = self.y - 70;
    } else {
        yStart = self.y - 30;
    }
    CGRect humanGemHolderSize = CGRectMake(10, yStart, 300, 50);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:humanGemHolderSize];
    [imageView.layer setCornerRadius:10.0f];
    [imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [imageView.layer setBorderWidth:1.0f];
    imageView.backgroundColor = self.game.human.color;
    [self.view addSubview:imageView];
    
    //initialize view objects
    int width = 50;
    int height = 50;
    self.gemOne = [[RFHGemImageContainer alloc] init];
    self.gemOne.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, yStart, width, height)];
    
    self.gemTwo = [[RFHGemImageContainer alloc] init];
    self.gemTwo.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, yStart, width, height)];
    
    self.gemThree = [[RFHGemImageContainer alloc] init];
    self.gemThree.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, yStart, width, height)];
    
    self.gemFour = [[RFHGemImageContainer alloc] init];
    self.gemFour.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(160, yStart, width, height)];
    
    self.gemFive = [[RFHGemImageContainer alloc] init];
    self.gemFive.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(210, yStart, width, height)];
    
    self.gemSix = [[RFHGemImageContainer alloc] init];
    self.gemSix.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, yStart, width, height)];
    
    // adding color to gem backgrounds to see frame size
    self.gemOne.imageView.backgroundColor = [UIColor clearColor];
    self.gemTwo.imageView.backgroundColor = [UIColor clearColor];
    self.gemThree.imageView.backgroundColor = [UIColor clearColor];
    self.gemFour.imageView.backgroundColor = [UIColor clearColor];
    self.gemFive.imageView.backgroundColor = [UIColor clearColor];
    self.gemSix.imageView.backgroundColor = [UIColor clearColor];
    
    //add starting gem images to view objects
    RFHGemObject *gem = self.game.humanGemHand[0];
    self.gemOne.imageView.image = gem.gemImage;
    
    gem = self.game.humanGemHand[1];
    self.gemTwo.imageView.image = gem.gemImage;
    gem = self.game.humanGemHand[2];
    self.gemThree.imageView.image = gem.gemImage;
    gem = self.game.humanGemHand[3];
    self.gemFour.imageView.image = gem.gemImage;
    gem = self.game.humanGemHand[4];
    self.gemFive.imageView.image = gem.gemImage;
    gem = self.game.humanGemHand[5];
    self.gemSix.imageView.image = gem.gemImage;
    
    // set GemImageContainer's gemOriginalCenter
    self.gemOne.gemOriginalCenter = self.gemOne.imageView.center;
    self.gemTwo.gemOriginalCenter = self.gemTwo.imageView.center;
    self.gemThree.gemOriginalCenter = self.gemThree.imageView.center;
    self.gemFour.gemOriginalCenter = self.gemFour.imageView.center;
    self.gemFive.gemOriginalCenter = self.gemFive.imageView.center;
    self.gemSix.gemOriginalCenter = self.gemSix.imageView.center;
    //int x = 50;
    //self.gemOne.gemOriginalCenter = CGPointMake(35, 523);
    //self.gemTwo.gemOriginalCenter = CGPointMake(35 + x, 523);
    //self.gemThree.gemOriginalCenter = CGPointMake(35 + 2 * x, 523);
    //self.gemFour.gemOriginalCenter = CGPointMake(35 + 3 * x, 523);
    //self.gemFive.gemOriginalCenter = CGPointMake(35 + 4 * x, 523);
    //self.gemSix.gemOriginalCenter = CGPointMake(35 + 5 * x, 523);
    
    // set gem's owner
    self.gemOne.owner = self.game.human;
    self.gemTwo.owner = self.game.human;
    self.gemThree.owner = self.game.human;
    self.gemFour.owner = self.game.human;
    self.gemFive.owner = self.game.human;
    self.gemSix.owner = self.game.human;
    
    // set gemContainers gem
    self.gemOne.gem = self.game.humanGemHand[0];
    self.gemTwo.gem = self.game.humanGemHand[1];
    self.gemThree.gem = self.game.humanGemHand[2];
    self.gemFour.gem = self.game.humanGemHand[3];
    self.gemFive.gem = self.game.humanGemHand[4];
    self.gemSix.gem = self.game.humanGemHand[5];
    
    
    
    // add gems to screen
    [self.view addSubview:self.gemOne.imageView];
    [self.view addSubview:self.gemTwo.imageView];
    [self.view addSubview:self.gemThree.imageView];
    [self.view addSubview:self.gemFour.imageView];
    [self.view addSubview:self.gemFive.imageView];
    [self.view addSubview:self.gemSix.imageView];
}

-(void)drawRobotHand
{
    CGRect robotGemHolderSize = CGRectMake(10, self.boardOffsetY - 60, 300, 50);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:robotGemHolderSize];
    [imageView.layer setCornerRadius:10.0f];
    [imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [imageView.layer setBorderWidth:1.0f];
    imageView.backgroundColor = self.game.robot.color;
    [self.view addSubview:imageView];
    
    //initialize view objects
    int width = 50;
    int height = 50;
    self.robotGemOne = [[RFHGemImageContainer alloc] init];
    self.robotGemOne.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.boardOffsetY - 60, width, height)];
    
    self.robotGemTwo = [[RFHGemImageContainer alloc] init];
    self.robotGemTwo.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, self.boardOffsetY - 60, width, height)];
    
    self.robotGemThree = [[RFHGemImageContainer alloc] init];
    self.robotGemThree.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, self.boardOffsetY - 60, width, height)];
    
    self.robotGemFour = [[RFHGemImageContainer alloc] init];
    self.robotGemFour.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(160, self.boardOffsetY - 60, width, height)];
    
    self.robotGemFive = [[RFHGemImageContainer alloc] init];
    self.robotGemFive.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(210, self.boardOffsetY - 60, width, height)];
    
    self.robotGemSix = [[RFHGemImageContainer alloc] init];
    self.robotGemSix.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, self.boardOffsetY - 60, width, height)];
    
    // adding color to gem backgrounds to see frame size
    self.robotGemOne.imageView.backgroundColor = [UIColor clearColor];
    self.robotGemTwo.imageView.backgroundColor = [UIColor clearColor];
    self.robotGemThree.imageView.backgroundColor = [UIColor clearColor];
    self.robotGemFour.imageView.backgroundColor = [UIColor clearColor];
    self.robotGemFive.imageView.backgroundColor = [UIColor clearColor];
    self.robotGemSix.imageView.backgroundColor = [UIColor clearColor];
    
    //add starting gem images to view objects
    RFHGemObject *gem = self.game.robotGemHand[0];
    self.robotGemOne.imageView.image = gem.gemImage;
    
    gem = self.game.robotGemHand[1];
    self.robotGemTwo.imageView.image = gem.gemImage;
    gem = self.game.robotGemHand[2];
    self.robotGemThree.imageView.image = gem.gemImage;
    gem = self.game.robotGemHand[3];
    self.robotGemFour.imageView.image = gem.gemImage;
    gem = self.game.robotGemHand[4];
    self.robotGemFive.imageView.image = gem.gemImage;
    gem = self.game.robotGemHand[5];
    self.robotGemSix.imageView.image = gem.gemImage;
    
    // set GemImageContainer's gemOriginalCenter
    self.robotGemOne.gemOriginalCenter = self.robotGemOne.imageView.center;
    self.robotGemTwo.gemOriginalCenter = self.robotGemTwo.imageView.center;
    self.robotGemThree.gemOriginalCenter = self.robotGemThree.imageView.center;
    self.robotGemFour.gemOriginalCenter = self.robotGemFour.imageView.center;
    self.robotGemFive.gemOriginalCenter = self.robotGemFive.imageView.center;
    self.robotGemSix.gemOriginalCenter = self.robotGemSix.imageView.center;
    
    // set gem's owner
    self.gemOne.owner = self.game.human;
    self.gemTwo.owner = self.game.human;
    self.gemThree.owner = self.game.human;
    self.gemFour.owner = self.game.human;
    self.gemFive.owner = self.game.human;
    self.gemSix.owner = self.game.human;
    
    // set gemContainers gem
    self.robotGemOne.gem = self.game.robotGemHand[0];
    self.robotGemTwo.gem = self.game.robotGemHand[1];
    self.robotGemThree.gem = self.game.robotGemHand[2];
    self.robotGemFour.gem = self.game.robotGemHand[3];
    self.robotGemFive.gem = self.game.robotGemHand[4];
    self.robotGemSix.gem = self.game.robotGemHand[5];
    
    
    
    // add gems to screen
    [self.view addSubview:self.robotGemOne.imageView];
    [self.view addSubview:self.robotGemTwo.imageView];
    [self.view addSubview:self.robotGemThree.imageView];
    [self.view addSubview:self.robotGemFour.imageView];
    [self.view addSubview:self.robotGemFive.imageView];
    [self.view addSubview:self.robotGemSix.imageView];

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
    if (self.iPhone4Inch) {
        return CGSizeMake(100, 70);
    } else {
        return CGSizeMake(100, 90);
    }
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

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
@property (nonatomic, strong) UIButton *buttonNextMove, *buttonPreviousMove;
@property (nonatomic) BOOL iPhone3Point5Inch;
@property (nonatomic) NSUInteger nextMoveCount;
@property (nonatomic) NSMutableArray *cellRects;

@end

@implementation RFHDetailGameCompletedViewController


-(instancetype)initWithGame:(RFHCompletedGame *)game
{
    if (self = [super init]) {
        _game = game;
        _cellRects = [[NSMutableArray alloc] init];
        self.nextMoveCount = 0;
        self.boardOffsetX = 10;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            //iPhone 5 screen
            self.boardOffsetY = 86 + 50;
            self.y = 498 - 52;
            self.iPhone3Point5Inch = NO;
            self.boardWidth = 300;
            self.boardHeight = 270;
        } else {
            //iPhone 4/4s screen
            self.boardOffsetY = 26 + 104;
            self.y = 418;
            self.boardWidth = 300;
            self.boardHeight = 210;
            self.iPhone3Point5Inch = YES;
        }
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _completedGameCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.boardOffsetX, self.boardOffsetY, self.boardWidth, self.boardHeight)
                                                 collectionViewLayout:layout];
        
        _buttonNextMove = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_buttonNextMove addTarget:self action:@selector(showNextMove) forControlEvents:UIControlEventTouchUpInside];
        _buttonPreviousMove = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_buttonPreviousMove addTarget:self action:@selector(showPreviousMove) forControlEvents:UIControlEventTouchUpInside];
        
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
    [self drawControls];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self createRects];
}

#pragma mark - Control Selectors

-(void)showNextMove
{
    //game.moveOrder is an array with 9 RFHGemImageContainers
    //RFHGemImageContainer has a gem
    //RFHGemImageContainer has an UIImageView and the UIImageView has a UIImage property
    //RFHGemImageContainer has an owner and the owner has a color property
    if (self.nextMoveCount < 9) {
        NSMutableArray *objectsOfInterest = [self.game.moveOrder objectAtIndex:self.nextMoveCount];
        RFHGemImageContainer *nextMove = objectsOfInterest[0];
        NSUInteger rectNumber = [objectsOfInterest[1] integerValue];
        CGRect cellRectOfInterest;
        cellRectOfInterest = [self.cellRects[rectNumber - 1] CGRectValue];
        NSUInteger gemNumber = [self whichGem:nextMove];
        if (gemNumber == 1) {
            [self centerImage:self.gemOne Rect:cellRectOfInterest];
        } else if (gemNumber == 2) {
            [self centerImage:self.gemTwo Rect:cellRectOfInterest];
        } else if (gemNumber == 3) {
            [self centerImage:self.gemThree Rect:cellRectOfInterest];
        } else if (gemNumber == 4) {
            [self centerImage:self.gemFour Rect:cellRectOfInterest];
        } else if (gemNumber == 5) {
            [self centerImage:self.gemFive Rect:cellRectOfInterest];
        } else if (gemNumber == 6) {
            [self centerImage:self.gemSix Rect:cellRectOfInterest];
            //
        } else if (gemNumber == 7) {
            [self centerImage:self.robotGemOne Rect:cellRectOfInterest];
        } else if (gemNumber == 8) {
            [self centerImage:self.robotGemTwo Rect:cellRectOfInterest];
        } else if (gemNumber == 9) {
            [self centerImage:self.robotGemThree Rect:cellRectOfInterest];
        } else if (gemNumber == 10) {
            [self centerImage:self.robotGemFour Rect:cellRectOfInterest];
        } else if (gemNumber == 11) {
            [self centerImage:self.robotGemFive Rect:cellRectOfInterest];
        } else if (gemNumber == 12) {
            [self centerImage:self.robotGemSix Rect:cellRectOfInterest];
        }

    }
    self.nextMoveCount++;
    [self.view setNeedsDisplay];
}

-(void)showPreviousMove
{
    NSLog(@"Showing Previous move!");
}


# pragma mark - Custom Game Functions

-(NSUInteger)whichGem:(RFHGemImageContainer *)gemImageContainer
{
    if (self.iPhone3Point5Inch) {
        if (gemImageContainer.gemOriginalCenter.x == 35 && gemImageContainer.gemOriginalCenter.y == 443) {
            return 1;
        } else if (gemImageContainer.gemOriginalCenter.x == 85 && gemImageContainer.gemOriginalCenter.y == 443) {
            return 2;
        } else if (gemImageContainer.gemOriginalCenter.x == 135 && gemImageContainer.gemOriginalCenter.y == 443) {
            return 3;
        } else if (gemImageContainer.gemOriginalCenter.x == 185 && gemImageContainer.gemOriginalCenter.y == 443) {
            return 4;
        } else if (gemImageContainer.gemOriginalCenter.x == 235 && gemImageContainer.gemOriginalCenter.y == 443) {
            return 5;
        } else if (gemImageContainer.gemOriginalCenter.x == 285 && gemImageContainer.gemOriginalCenter.y == 443) {
            return 6;
        }
    } else {
        
    } if (gemImageContainer.gemOriginalCenter.x == 35 && gemImageContainer.gemOriginalCenter.y == 523) {
        return 1;
    } else if (gemImageContainer.gemOriginalCenter.x == 85 && gemImageContainer.gemOriginalCenter.y == 523) {
        return 2;
    } else if (gemImageContainer.gemOriginalCenter.x == 135 && gemImageContainer.gemOriginalCenter.y == 523) {
        return 3;
    } else if (gemImageContainer.gemOriginalCenter.x == 185 && gemImageContainer.gemOriginalCenter.y == 523) {
        return 4;
    } else if (gemImageContainer.gemOriginalCenter.x == 235 && gemImageContainer.gemOriginalCenter.y == 523) {
        return 5;
    } else if (gemImageContainer.gemOriginalCenter.x == 285 && gemImageContainer.gemOriginalCenter.y == 523) {
        return 6;
        //
    } else if (gemImageContainer.gemOriginalCenter.x == 35 && gemImageContainer.gemOriginalCenter.y == 101) {
        return 7;
    } else if (gemImageContainer.gemOriginalCenter.x == 85 && gemImageContainer.gemOriginalCenter.y == 101) {
        return 8;
    } else if (gemImageContainer.gemOriginalCenter.x == 135 && gemImageContainer.gemOriginalCenter.y == 101) {
        return 9;
    } else if (gemImageContainer.gemOriginalCenter.x == 185 && gemImageContainer.gemOriginalCenter.y == 101) {
        return 10;
    } else if (gemImageContainer.gemOriginalCenter.x == 235 && gemImageContainer.gemOriginalCenter.y == 101) {
        return 11;
    } else if (gemImageContainer.gemOriginalCenter.x == 285 && gemImageContainer.gemOriginalCenter.y == 101) {
        return 12;
    }

    return 0;
}

-(void)createRects
{
    NSArray *visibleCellIndex = self.completedGameCollectionView.indexPathsForVisibleItems;
    NSSortDescriptor *rowDescriptor = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
    NSArray *sortedVisibleCells = [visibleCellIndex sortedArrayUsingDescriptors:@[rowDescriptor]];

    UICollectionViewCell *cell;
    cell = [self.completedGameCollectionView cellForItemAtIndexPath:sortedVisibleCells[0]];
    CGRect rect;
    rect.origin = cell.frame.origin;
    rect.size = cell.frame.size;
    [self.cellRects addObject:[NSValue valueWithCGRect:rect]];
    
    cell = [self.completedGameCollectionView cellForItemAtIndexPath:sortedVisibleCells[1]];
    CGRect rect2;
    rect2.origin = cell.frame.origin;
    rect2.size = cell.frame.size;
    [self.cellRects addObject:[NSValue valueWithCGRect:rect2]];
    
    cell = [self.completedGameCollectionView cellForItemAtIndexPath:sortedVisibleCells[2]];
    CGRect rect3;
    rect3.origin = cell.frame.origin;
    rect3.size = cell.frame.size;
    [self.cellRects addObject:[NSValue valueWithCGRect:rect3]];
    
    cell = [self.completedGameCollectionView cellForItemAtIndexPath:sortedVisibleCells[3]];
    CGRect rect4;
    rect4.origin = cell.frame.origin;
    rect4.size = cell.frame.size;
    [self.cellRects addObject:[NSValue valueWithCGRect:rect4]];
    
    cell = [self.completedGameCollectionView cellForItemAtIndexPath:sortedVisibleCells[4]];
    CGRect rect5;
    rect5.origin = cell.frame.origin;
    rect5.size = cell.frame.size;
    [self.cellRects addObject:[NSValue valueWithCGRect:rect5]];
    
    cell = [self.completedGameCollectionView cellForItemAtIndexPath:sortedVisibleCells[5]];
    CGRect rect6;
    rect6.origin = cell.frame.origin;
    rect6.size = cell.frame.size;
    [self.cellRects addObject:[NSValue valueWithCGRect:rect6]];
    
    cell = [self.completedGameCollectionView cellForItemAtIndexPath:sortedVisibleCells[6]];
    CGRect rect7;
    rect7.origin = cell.frame.origin;
    rect7.size = cell.frame.size;
    [self.cellRects addObject:[NSValue valueWithCGRect:rect7]];
    
    cell = [self.completedGameCollectionView cellForItemAtIndexPath:sortedVisibleCells[7]];
    CGRect rect8;
    rect8.origin = cell.frame.origin;
    rect8.size = cell.frame.size;
    [self.cellRects addObject:[NSValue valueWithCGRect:rect8]];
    
    cell = [self.completedGameCollectionView cellForItemAtIndexPath:sortedVisibleCells[8]];
    CGRect rect9;
    rect9.origin = cell.frame.origin;
    rect9.size = cell.frame.size;
    [self.cellRects addObject:[NSValue valueWithCGRect:rect9]];
    
    
    
}

-(void)centerImage:(RFHGemImageContainer *)imageContainer Rect:(CGRect)rect
{

    float x = CGRectGetMidX(rect) + self.boardOffsetX;
    float y = CGRectGetMidY(rect) + self.boardOffsetY;
    imageContainer.imageView.center = CGPointMake(x,y);
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
    if (self.iPhone3Point5Inch) {
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

-(void)drawControls
{
    CGRect buttonNextMoveFrame, buttonPreviousMoveFrame;
    
    if (self.iPhone3Point5Inch) {
        buttonNextMoveFrame = CGRectMake(170, self.y - 20, 50, 50);
        buttonPreviousMoveFrame = CGRectMake(50, self.y - 20, 50, 50);
    } else {
        buttonNextMoveFrame = CGRectMake(170, self.y + 20, 100, 100);
        buttonPreviousMoveFrame = CGRectMake(50, self.y + 20, 100, 100);
    }
    self.buttonNextMove.frame = buttonNextMoveFrame;
    UIImage *backgroundImage = [UIImage imageNamed:@"NextMoveButton.png"];
    [self.buttonNextMove setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    self.buttonPreviousMove.frame = buttonPreviousMoveFrame;
    backgroundImage = [UIImage imageNamed:@"PreviousMoveButton.png"];
    [self.buttonPreviousMove setBackgroundImage:backgroundImage forState:UIControlStateNormal];

    
    [self.view addSubview:self.buttonNextMove];
    [self.view addSubview:self.buttonPreviousMove];
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
    if (self.iPhone3Point5Inch) {
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

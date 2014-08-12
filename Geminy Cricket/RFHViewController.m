//
//  RFHViewController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 4/12/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHViewController.h"
#import "RFHGemObject.h"
#import "RFHGemImageContainer.h"
#import "RFHGameBoard.h"
#import "RFHHumanPlayer.h"
#import "RFHRobotPlayer.h"
#import "RFHAppDelegate.h"
#import "RFHCompletedGame.h"
#import "QuartzCore/CALayer.h"

@interface RFHViewController ()


@end

@implementation RFHViewController
{
    RFHGameBoard *board;
    NSMutableArray *gemHand;
    RFHGemImageContainer *touchedGem;
    RFHHumanPlayer *human;
    NSInteger moveCount;
    
    RFHRobotPlayer *robotOpponent;
    NSMutableArray *robotGemHand;
    
    CGRect cellOneRectangle, cellTwoRectangle, cellThreeRectangle, cellFourRectangle, cellFiveRectangle, cellSixRectangle, cellSevenRectangle, cellEightRectangle, cellNineRectangle;
    CGRect gemOneRect, gemTwoRect, gemThreeRect, gemFourRect, gemFiveRect, gemSixRect;

    NSMutableDictionary *myItems;
    NSMutableDictionary *numberMappings;
    
    NSMutableArray *vacantCells;
    
    NSInteger boardOffsetX, boardOffsetY;
    
    UIButton *resetButton;
    UIButton *homeScreenButton;
    
    NSUInteger humanTotal;
    
    NSMutableArray *usedRobotIndices;
    
    BOOL iPhone3Point5Inch;
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)doEverything
{
	// Do any additional setup after loading the view, typically from a nib.
    usedRobotIndices = [[NSMutableArray alloc] init];
    humanTotal = 0;
    board = [[RFHGameBoard alloc] init];
    board.boardObjects = [[NSMutableArray alloc] init];
    board.boardColors = [[NSMutableArray alloc] init];
    board.boardBools = [[NSMutableArray alloc] init];
    self.moveOrder = [[NSMutableArray alloc] init];
    gemHand = [[NSMutableArray alloc] init];
    robotGemHand = [[NSMutableArray alloc] init];
    human = [[RFHHumanPlayer alloc] initWithName:@"RYGUY" Color:[UIColor colorWithRed:.0274509 green:.596078 blue:.788235 alpha:1.0]];
    robotOpponent = [[RFHRobotPlayer alloc] initWithName:@"Robopponent" Color:[UIColor colorWithRed:.78431 green:.215686 blue:.0274509 alpha:1.0]];
    [self initializeRobotGemHand];
    
    int y;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        //iPhone 5 screen
        boardOffsetY = 86;
        y = 498;
        iPhone3Point5Inch = NO;
    } else {
        //iPhone 4/4s screen
        boardOffsetY = 26 + 45;
        y = 418;
        iPhone3Point5Inch = YES;
    }
    
    boardOffsetX = 10;
    moveCount = 0;
    
    //for (int i = 0; i < 9; i++) {
    //    [board.boardObjects addObject:[RFHGemObject randomGem]];
    //}
    for (int i = 0; i < 9; i++) {
        [board.boardObjects addObject:[NSNull null]];
    }
    for (int i = 0; i < 9; i++) {
        [board.boardBools addObject:[NSNumber numberWithBool:NO]];
    }
    for (int i = 0; i < 9; i++) {
        [board.boardColors addObject:[NSNull null]];
    }
    
    if ([self turnMoveOrder] == 1) {
        [self populateFirstPlayerGemHand:gemHand];
        [self populateFirstPlayerGemHand:robotGemHand];
        human.turn = YES;
        robotOpponent.turn = NO;
    } else {
        [self populateFirstPlayerGemHand:robotGemHand];
        [self populateSecondPlayerGemHand:gemHand];
        human.turn = NO;
        robotOpponent.turn = YES;
        [self performSelector:@selector(robotMakeTurn) withObject:self afterDelay:2];
    }

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    if (iPhone3Point5Inch) {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(boardOffsetX, boardOffsetY, 300, 330)
                                                 collectionViewLayout:layout];
    } else {
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(boardOffsetX, boardOffsetY, 300, 375)
                                             collectionViewLayout:layout];
    }
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView.layer setCornerRadius:10.0f];
    [self.collectionView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.collectionView.layer setBorderWidth:1.0f];

    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"boardCell"];
    self.collectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.collectionView];
    

    
    // Make background gem rect holder to signify player color
    CGRect humanGemHolderSize = CGRectMake(10, y, 300, 50);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:humanGemHolderSize];
    [imageView.layer setCornerRadius:10.0f];
    [imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [imageView.layer setBorderWidth:1.0f];
    imageView.backgroundColor = [UIColor colorWithRed:.0274509 green:.596078 blue:.788235 alpha:1.0];
    [self.view addSubview:imageView];

    //initialize view objects
    int width = 50;
    int height = 50;
    self.gemOne = [[RFHGemImageContainer alloc] init];
    self.gemOne.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, y, width, height)];

    self.gemTwo = [[RFHGemImageContainer alloc] init];
    self.gemTwo.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, y, width, height)];
    
    self.gemThree = [[RFHGemImageContainer alloc] init];
    self.gemThree.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, y, width, height)];
    
    self.gemFour = [[RFHGemImageContainer alloc] init];
    self.gemFour.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(160, y, width, height)];
    
    self.gemFive = [[RFHGemImageContainer alloc] init];
    self.gemFive.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(210, y, width, height)];
    
    self.gemSix = [[RFHGemImageContainer alloc] init];
    self.gemSix.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, y, width, height)];
    
    // adding color to gem backgrounds to see frame size
    self.gemOne.imageView.backgroundColor = [UIColor clearColor];
    self.gemTwo.imageView.backgroundColor = [UIColor clearColor];
    self.gemThree.imageView.backgroundColor = [UIColor clearColor];
    self.gemFour.imageView.backgroundColor = [UIColor clearColor];
    self.gemFive.imageView.backgroundColor = [UIColor clearColor];
    self.gemSix.imageView.backgroundColor = [UIColor clearColor];
    
    //add starting gem images to view objects
    RFHGemObject *gem = gemHand[0];
    self.gemOne.imageView.image = gem.gemImage;
    
    gem = gemHand[1];
    self.gemTwo.imageView.image = gem.gemImage;
    gem = gemHand[2];
    self.gemThree.imageView.image = gem.gemImage;
    gem = gemHand[3];
    self.gemFour.imageView.image = gem.gemImage;
    gem = gemHand[4];
    self.gemFive.imageView.image = gem.gemImage;
    gem = gemHand[5];
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
    self.gemOne.owner = human;
    self.gemTwo.owner = human;
    self.gemThree.owner = human;
    self.gemFour.owner = human;
    self.gemFive.owner = human;
    self.gemSix.owner = human;
    
    // set gemContainers gem
    self.gemOne.gem = gemHand[0];
    self.gemTwo.gem = gemHand[1];
    self.gemThree.gem = gemHand[2];
    self.gemFour.gem = gemHand[3];
    self.gemFive.gem = gemHand[4];
    self.gemSix.gem = gemHand[5];
    
    
    
    // add gems to screen
    [self.view addSubview:self.gemOne.imageView];
    [self.view addSubview:self.gemTwo.imageView];
    [self.view addSubview:self.gemThree.imageView];
    [self.view addSubview:self.gemFour.imageView];
    [self.view addSubview:self.gemFive.imageView];
    [self.view addSubview:self.gemSix.imageView];
    
    // number mappings
    numberMappings = [[NSMutableDictionary alloc] initWithDictionary:@{@"1": @"One",
                                                                       @"2": @"Two",
                                                                       @"3": @"Three",
                                                                       @"4": @"Four",
                                                                       @"5": @"Five",
                                                                       @"6": @"Six",
                                                                       @"7": @"Seven",
                                                                       @"8": @"Eight",
                                                                       @"9": @"Nine"}];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient.png"]];
}

-(void)loadView
{
    [super loadView];
    [self doEverything];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self assignCellRectangleValues];
}

#pragma mark - Touch Controls

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    touchedGem = nil;

    //if gem one is clicked, set touched gem to gem one
    if (human.turn) {
        if (!self.gemOne.onBoard && CGRectContainsPoint(gemOneRect, location)) {
            touchedGem = self.gemOne;
        } else if (!self.gemTwo.onBoard && CGRectContainsPoint(gemTwoRect, location)) {
            touchedGem = self.gemTwo;
        } else if (!self.gemThree.onBoard && CGRectContainsPoint(gemThreeRect, location)) {
            touchedGem = self.gemThree;
        } else if (!self.gemFour.onBoard && CGRectContainsPoint(gemFourRect, location)) {
            touchedGem = self.gemFour;
        } else if (!self.gemFive.onBoard && CGRectContainsPoint(gemFiveRect, location)) {
            touchedGem = self.gemFive;
        } else if (!self.gemSix.onBoard && CGRectContainsPoint(gemSixRect, location)) {
            touchedGem = self.gemSix;
        }
    }
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    if (touchedGem) {
        touchedGem.imageView.center = location;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint collectionLocation = [touch locationInView:self.collectionView];
    //NSLog(@"The location in the collection view is %f, %f", collectionLocation.x, collectionLocation.y);
    
    CGPoint location = [touch locationInView:touch.view];
    
    BOOL humanMoveMade = NO;
    
    // if my gem is not on the grid when I let go, send it back to it's original location
    CGRect collectionViewRect;
    collectionViewRect.origin = self.collectionView.frame.origin;
    collectionViewRect.size = self.collectionView.frame.size;
    //if gem not dropped on board, return the gem to gem Hand
    if (!CGRectContainsPoint(collectionViewRect, location)) {
        touchedGem.imageView.center = touchedGem.gemOriginalCenter;
    } else if (touchedGem) {
        //check the 9 spots for which one the gem was dropped into
        if (CGRectContainsPoint(cellOneRectangle, collectionLocation)) {
            //if there is already an object here, return the gem to gem hand
            //otherwise, place the gem down
            if ([board.boardBools[0] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                humanMoveMade = YES;
                board.boardObjects[0] = touchedGem;
                board.boardColors[0] = touchedGem.owner.color;
                board.boardBools[0] = [NSNumber numberWithBool:YES];
                [self.moveOrder addObject:@[touchedGem, @1]];
                vacantCells[0] = [NSNull null];
                [self centerImage:touchedGem Rect:cellOneRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellTwoRectangle, collectionLocation)) {
            if ([board.boardBools[1] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                humanMoveMade = YES;
                board.boardObjects[1] = touchedGem;
                board.boardColors[1] = touchedGem.owner.color;
                board.boardBools[1] = [NSNumber numberWithBool:YES];
                [self.moveOrder addObject:@[touchedGem, @2]];
                vacantCells[1] = [NSNull null];
                [self centerImage:touchedGem Rect:cellTwoRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
                }
        } else if (CGRectContainsPoint(cellThreeRectangle, collectionLocation)) {
            if ([board.boardBools[2] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                humanMoveMade = YES;
                board.boardObjects[2] = touchedGem;
                board.boardColors[2] = touchedGem.owner.color;
                board.boardBools[2] = [NSNumber numberWithBool:YES];
                [self.moveOrder addObject:@[touchedGem, @3]];
                vacantCells[2] = [NSNull null];
                [self centerImage:touchedGem Rect:cellThreeRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellFourRectangle, collectionLocation)) {
            if ([board.boardBools[3] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                humanMoveMade = YES;
                board.boardObjects[3] = touchedGem;
                board.boardColors[3] = touchedGem.owner.color;
                board.boardBools[3] = [NSNumber numberWithBool:YES];
                [self.moveOrder addObject:@[touchedGem, @4]];
                vacantCells[3] = [NSNull null];
                [self centerImage:touchedGem Rect:cellFourRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellFiveRectangle, collectionLocation)) {
            if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                humanMoveMade = YES;
                board.boardObjects[4] = touchedGem;
                board.boardColors[4] = touchedGem.owner.color;
                board.boardBools[4] = [NSNumber numberWithBool:YES];
                [self.moveOrder addObject:@[touchedGem, @5]];
                vacantCells[4] = [NSNull null];
                [self centerImage:touchedGem Rect:cellFiveRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellSixRectangle, collectionLocation)) {
            if ([board.boardBools[5] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                humanMoveMade = YES;
                board.boardObjects[5] = touchedGem;
                board.boardColors[5] = touchedGem.owner.color;
                board.boardBools[5] = [NSNumber numberWithBool:YES];
                [self.moveOrder addObject:@[touchedGem, @6]];
                vacantCells[5] = [NSNull null];
                [self centerImage:touchedGem Rect:cellSixRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellSevenRectangle, collectionLocation)) {
            if ([board.boardBools[6] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                humanMoveMade = YES;
                board.boardObjects[6] = touchedGem;
                board.boardColors[6] = touchedGem.owner.color;
                board.boardBools[6] = [NSNumber numberWithBool:YES];
                [self.moveOrder addObject:@[touchedGem, @7]];
                vacantCells[6] = [NSNull null];
                [self centerImage:touchedGem Rect:cellSevenRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellEightRectangle, collectionLocation)) {
            if ([board.boardBools[7] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                humanMoveMade = YES;
                board.boardObjects[7] = touchedGem;
                board.boardColors[7] = touchedGem.owner.color;
                board.boardBools[7] = [NSNumber numberWithBool:YES];
                [self.moveOrder addObject:@[touchedGem, @8]];
                vacantCells[7] = [NSNull null];
                [self centerImage:touchedGem Rect:cellEightRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellNineRectangle, collectionLocation)) {
            if ([board.boardBools[8] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                humanMoveMade = YES;
                board.boardObjects[8] = touchedGem;
                board.boardColors[8] = touchedGem.owner.color;
                board.boardBools[8] = [NSNumber numberWithBool:YES];
                [self.moveOrder addObject:@[touchedGem, @9]];
                vacantCells[8] = [NSNull null];
                [self centerImage:touchedGem Rect:cellNineRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        }
        
        if ([self isGameOver]) {
            [self declareWinner];
        } else if (humanMoveMade) {
            [self changeTurnOrder];
            [self performSelector:@selector(robotMakeTurn) withObject:self afterDelay:1];
        }
    }
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"boardCell"
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:.917647 green:.831372 blue:.341176 alpha:1.0];
    
    
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone3Point5Inch) {
        return CGSizeMake(100, 110);
    } else {
        return CGSizeMake(100, 125);
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



#pragma mark - Custom Game Functions

-(NSUInteger)turnMoveOrder
{
    NSUInteger val = 0;
    while (val == 0) {
        val = arc4random() % 3;
    }
    return val;
}

-(void)populateFirstPlayerGemHand:(NSMutableArray *)hand
{
    [hand addObject:[RFHGemObject weakGem]];
    [hand addObject:[RFHGemObject strongGem]];
    [hand addObject:[RFHGemObject middleGem]];
    [hand addObject:[RFHGemObject randomGem]];
    [hand addObject:[RFHGemObject middleGem]];
    [hand addObject:[RFHGemObject lowRangeGem]];
}

-(void)populateSecondPlayerGemHand:(NSMutableArray *)hand
{
    [hand addObject:[RFHGemObject weakGem]];
    [hand addObject:[RFHGemObject strongGem]];
    [hand addObject:[RFHGemObject middleGem]];
    [hand addObject:[RFHGemObject strongGem]];
    [hand addObject:[RFHGemObject randomGem]];
    [hand addObject:[RFHGemObject highRangeGem]];
}

-(void)centerImage:(RFHGemImageContainer *)imageContainer Rect:(CGRect)rect
{
    float x = CGRectGetMidX(rect) + boardOffsetX;
    float y = CGRectGetMidY(rect) + boardOffsetY;
    imageContainer.imageView.center = CGPointMake(x,y);
}

-(void)robotMakeTurn
{
    UICollectionViewCell *cell;
    RFHGemObject *gem;
    int cellIndex = 0;
    int index = 0;
    while (!cell) {
        cellIndex = arc4random_uniform((uint32_t)[vacantCells count]);
        if (vacantCells[cellIndex] != [NSNull null]) {
            cell = vacantCells[cellIndex];
            board.boardColors[cellIndex] = robotOpponent.color;
            board.boardBools[cellIndex] = [NSNumber numberWithBool:YES];
        }
    }
    while (!gem) {
        index = arc4random() % [robotGemHand count];
        if (![usedRobotIndices containsObject:[NSNumber numberWithInt:index]]) {
            gem = robotGemHand[index];
            [usedRobotIndices addObject:[NSNumber numberWithInt:index]];
        }
    }
    RFHGemImageContainer *robotGemImage = [[RFHGemImageContainer alloc] initRobotGemContainer:gem Player:robotOpponent onBoard:YES];
    board.boardObjects[cellIndex] = robotGemImage;
    vacantCells[cellIndex] = [NSNull null];
    NSString *cellName = [NSString stringWithFormat:@"cell%@Rectangle", [numberMappings objectForKey:[NSString stringWithFormat:@"%d", cellIndex + 1]]];
    CGRect cellRect = [[myItems objectForKey:cellName] CGRectValue];
    robotGemImage.imageView.center = CGPointMake(CGRectGetMidX(cellRect) + boardOffsetX, CGRectGetMidY(cellRect) + boardOffsetY);
    [self setRobotGemOriginalCenter:robotGemImage gemPosition:index+1];
    [self addRobotMoveToMoveOrder:robotGemImage withCellIndex:cellIndex];
    [self.view addSubview:robotGemImage.imageView];
    [self boardCheck:robotGemImage collectionLocation:cell.center];
    [self changeTurnOrder];
    
    if ([self isGameOver]) {
        [self declareWinner];
        [self changeTurnOrder];
    }
}

-(void)setRobotGemOriginalCenter:(RFHGemImageContainer *)robotGemImage gemPosition:(int)gemPosition
{
    if (gemPosition == 1) {
        robotGemImage.gemOriginalCenter = CGPointMake(35, 101);
    } else if (gemPosition == 2) {
        robotGemImage.gemOriginalCenter = CGPointMake(85, 101);
    } else if (gemPosition == 3) {
        robotGemImage.gemOriginalCenter = CGPointMake(135, 101);
    } else if (gemPosition == 4) {
        robotGemImage.gemOriginalCenter = CGPointMake(185, 101);
    } else if (gemPosition == 5) {
        robotGemImage.gemOriginalCenter = CGPointMake(235, 101);
    } else if (gemPosition == 6) {
        robotGemImage.gemOriginalCenter = CGPointMake(285, 101);
    }
}
-(void)addRobotMoveToMoveOrder:(RFHGemImageContainer *)robotGemImage withCellIndex:(int)cellIndex
{
    if (cellIndex == 0) {
        [self.moveOrder addObject:@[robotGemImage, @1]];
    } else if (cellIndex == 1) {
        [self.moveOrder addObject:@[robotGemImage, @2]];
    } else if (cellIndex == 2) {
        [self.moveOrder addObject:@[robotGemImage, @3]];
    } else if (cellIndex == 3) {
        [self.moveOrder addObject:@[robotGemImage, @4]];
    } else if (cellIndex == 4) {
        [self.moveOrder addObject:@[robotGemImage, @5]];
    } else if (cellIndex == 5) {
        [self.moveOrder addObject:@[robotGemImage, @6]];
    } else if (cellIndex == 6) {
        [self.moveOrder addObject:@[robotGemImage, @7]];
    } else if (cellIndex == 7) {
        [self.moveOrder addObject:@[robotGemImage, @8]];
    } else if (cellIndex == 8) {
        [self.moveOrder addObject:@[robotGemImage, @9]];
    }
}

-(void)changeTurnOrder
{
    if (!human.turn) {
        human.turn = YES;
        robotOpponent.turn = NO;
    } else {
        human.turn = NO;
        robotOpponent.turn = YES;
    }
}


-(BOOL)isGameOver
{
    if (moveCount >= 9) {
        return true;
    }
    return false;
}

-(void)declareWinner
{
    for (UIColor *color in board.boardColors) {
        if (color == human.color) {
            humanTotal++;
        }
    }
    UIImageView *scrollView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 100, 180, 250)];
    UIImage *scrollImage = [UIImage imageNamed:@"scroll_90opacity.png"];
    scrollView.image = scrollImage;
    
    
    resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetButton.layer.cornerRadius = 5.0f;
    [resetButton addTarget:self action:@selector(resetGame) forControlEvents:UIControlEventTouchUpInside];
    [resetButton setTitle:@"Replay" forState:UIControlStateNormal];
    resetButton.frame = CGRectMake(120, 250, 65, 30);
    resetButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    [self.view addSubview:resetButton];
    
    homeScreenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    homeScreenButton.layer.cornerRadius = 5.0f;
    [homeScreenButton addTarget:self action:@selector(returnHome) forControlEvents:UIControlEventTouchUpInside];
    [homeScreenButton setTitle:@"Home" forState:UIControlStateNormal];
    homeScreenButton.frame = CGRectMake(120, 210, 65, 30);
    homeScreenButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:homeScreenButton];

    
    RFHCompletedGame *completedGame = [[RFHCompletedGame alloc] init];
    completedGame.moveOrder = self.moveOrder;
    completedGame.humanGemHand = gemHand;
    completedGame.human = human;
    completedGame.robotGemHand = robotGemHand;
    completedGame.robot = robotOpponent;
    
    NSInteger robotTotal = 9 - humanTotal;
    NSString *labelText;
    if (humanTotal >= 5) {
        RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.wins++;
        if (humanTotal > appDelegate.bestWin) {
            appDelegate.bestWin = humanTotal;
        }
        if (humanTotal == 9) {
            appDelegate.flawlessVictories++;
        }
        //create victory label, place on screen
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 120, 75)];
        labelText = @"VICTORY";
        label.text = labelText;
        label.textColor = [UIColor colorWithRed:.22 green:.8 blue:.33 alpha:1.0];
        //label.font = [label.font fontWithSize:25];
        label.font = [UIFont fontWithName:@"Zapfino" size:15];
        completedGame.outcome = [NSString stringWithFormat:@"%@ (%lu - %lu)", labelText, (unsigned long)humanTotal, (unsigned long)robotTotal];
        completedGame.humanVictory = YES;
        [self.view addSubview:label];
    } else {
        RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.losses++;
        if ((9 - humanTotal) > appDelegate.worstLoss) {
            appDelegate.worstLoss = (9 - humanTotal);
        }
        //create defeat label, place on screen
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 120, 75)];
        labelText = @"DEFEAT";
        label.text = labelText;
        label.textColor = [UIColor colorWithRed:.8 green:.22 blue:.1 alpha:1.0];
        label.font = [UIFont fontWithName:@"Zapfino" size:15];
        completedGame.outcome = [NSString stringWithFormat:@"%@ (%lu - %lu)", labelText, (unsigned long)humanTotal, (unsigned long)robotTotal];
        [self.view addSubview:label];
    }
    
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.gameHistoryController.completedGames addObject:completedGame];

}
/*

-(void)gameLoop {
    //show screen counting down till game begins, then load board and gem hand
    if (![self isGameOver]) {
        //allow player to make move
        //allow robot to make move
    }
    NSString *winner = [self declareWinner];
}*/

-(void)boardCheck:(RFHGemImageContainer *)sender collectionLocation:(CGPoint)loc {
    //check adajacencies
    if ([board.boardObjects indexOfObject:sender] == 0) {
        //check board[1] and board[3]
        if ([board.boardBools[1] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[1];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[1] = sender.owner.color;
                //[self updateBoardColorV2:CGPointMake(CGRectGetMidX(cellOneRectangle), CGRectGetMidY(cellOneRectangle))];
                [self boardColorUpdate:1];
            }
        }
        if ([board.boardBools[3] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[3];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[3] = sender.owner.color;
                [self boardColorUpdate:3];
            }
        }
    } else if ([board.boardObjects indexOfObject:sender] == 1) {
        //check board[0] and board[2] and board[3]
        if ([board.boardBools[0] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[0];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[0] = sender.owner.color;
                [self boardColorUpdate:0];
            }
        }
        if ([board.boardBools[2] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[2];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[2] = sender.owner.color;
                [self boardColorUpdate:2];
            }
        }
        if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[4];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[4] = sender.owner.color;
                [self boardColorUpdate:4];
            }
        }
        
    } else if ([board.boardObjects indexOfObject:sender] == 2) {
        //check board[1] and board[5]
        if ([board.boardBools[1] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[1];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[1] = sender.owner.color;
                [self boardColorUpdate:1];
            }
        }
        if ([board.boardBools[5] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[5];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[5] = sender.owner.color;
                [self boardColorUpdate:5];
            }
        }
        
    } else if ([board.boardObjects indexOfObject:sender] == 3) {
        //check board[0] and board[4] and board[6]
        if ([board.boardBools[0] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[0];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[0] = sender.owner.color;
                [self boardColorUpdate:0];
            }
        }
        if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[4];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[4] = sender.owner.color;
                [self boardColorUpdate:4];
            }
        }
        if ([board.boardBools[6] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[6];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[6] = sender.owner.color;
                [self boardColorUpdate:6];
            }
        }
        
    }  else if ([board.boardObjects indexOfObject:sender] == 4) {
        //check board[1] and board[3] and board[5] and board[7]
        if ([board.boardBools[1] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[1];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[1] = sender.owner.color;
                [self boardColorUpdate:1];
            }
        }
        if ([board.boardBools[3] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[3];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[3] = sender.owner.color;
                [self boardColorUpdate:3];
            }
        }
        if ([board.boardBools[5] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[5];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[5] = sender.owner.color;
                [self boardColorUpdate:5];
            }
        }
        if ([board.boardBools[7] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[7];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[7] = sender.owner.color;
                [self boardColorUpdate:7];
            }
        }
        
    } else if ([board.boardObjects indexOfObject:sender] == 5) {
        //check board[2] and board[4] and board[8]
        if ([board.boardBools[2] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[2];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[2] = sender.owner.color;
                [self boardColorUpdate:2];
            }
        }
        if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[4];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[4] = sender.owner.color;
                [self boardColorUpdate:4];
            }
        }
        if ([board.boardBools[8] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[8];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[8] = sender.owner.color;
                [self boardColorUpdate:8];
            }
        }
        
    } else if ([board.boardObjects indexOfObject:sender] == 6) {
        //check board[3] and board[7]
        if ([board.boardBools[3] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[3];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[3] = sender.owner.color;
                [self boardColorUpdate:3];
            }
        }
        if ([board.boardBools[7] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[7];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[7] = sender.owner.color;
                [self boardColorUpdate:7];
            }
        }
    }  else if ([board.boardObjects indexOfObject:sender] == 7) {
        //check board[6] and board[4] and board[8]
        if ([board.boardBools[6] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[6];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[6] = sender.owner.color;
                [self boardColorUpdate:6];
            }
        }
        if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[4];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[4] = sender.owner.color;
                [self boardColorUpdate:4];
            }
        }
        if ([board.boardBools[8] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[8];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[8] = sender.owner.color;
                [self boardColorUpdate:8];
            }
        }
    } else if ([board.boardObjects indexOfObject:sender] == 8) {
        //check board[5] and board[7]
        if ([board.boardBools[5] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[5];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[5] = sender.owner.color;
                [self boardColorUpdate:5];
            }
        }
        if ([board.boardBools[7] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[7];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardColors[7] = sender.owner.color;
                [self boardColorUpdate:7];
            }
        }
    }
    moveCount++;
    [self updateBoardColorV2:loc];
}

-(void)initializeRobotGemHand
{

}

-(void)assignCellRectangleValues
{
    NSArray *visibleCellIndex = self.collectionView.indexPathsForVisibleItems;
    NSSortDescriptor *rowDescriptor = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
    NSArray *sortedVisibleCells = [visibleCellIndex sortedArrayUsingDescriptors:@[rowDescriptor]];
    vacantCells = [[NSMutableArray alloc] init];
    for (int i=0; i < [sortedVisibleCells count]; i++) {
        [vacantCells addObject:[self.collectionView cellForItemAtIndexPath:sortedVisibleCells[i]]];
    }
    UICollectionViewCell *cell;
    cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[0]];
    cellOneRectangle.origin = cell.frame.origin;
    cellOneRectangle.size = cell.frame.size;
    cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[1]];
    cellTwoRectangle.origin = cell.frame.origin;
    cellTwoRectangle.size = cell.frame.size;
    cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[2]];
    cellThreeRectangle.origin = cell.frame.origin;
    cellThreeRectangle.size = cell.frame.size;
    cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[3]];
    cellFourRectangle.origin = cell.frame.origin;
    cellFourRectangle.size = cell.frame.size;
    cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[4]];
    cellFiveRectangle.origin = cell.frame.origin;
    cellFiveRectangle.size = cell.frame.size;
    cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[5]];
    cellSixRectangle.origin = cell.frame.origin;
    cellSixRectangle.size = cell.frame.size;
    cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[6]];
    cellSevenRectangle.origin = cell.frame.origin;
    cellSevenRectangle.size = cell.frame.size;
    cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[7]];
    cellEightRectangle.origin = cell.frame.origin;
    cellEightRectangle.size = cell.frame.size;
    cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[8]];
    cellNineRectangle.origin = cell.frame.origin;
    cellNineRectangle.size = cell.frame.size;

    gemOneRect.origin = self.gemOne.imageView.frame.origin;
    gemOneRect.size = self.gemOne.imageView.bounds.size;
    gemTwoRect.origin = self.gemTwo.imageView.frame.origin;
    gemTwoRect.size = self.gemTwo.imageView.bounds.size;
    gemThreeRect.origin = self.gemThree.imageView.frame.origin;
    gemThreeRect.size = self.gemThree.imageView.bounds.size;
    gemFourRect.origin = self.gemFour.imageView.frame.origin;
    gemFourRect.size = self.gemFour.imageView.bounds.size;
    gemFiveRect.origin = self.gemFive.imageView.frame.origin;
    gemFiveRect.size = self.gemFive.imageView.bounds.size;
    gemSixRect.origin = self.gemSix.imageView.frame.origin;
    gemSixRect.size = self.gemSix.imageView.bounds.size;
    
    myItems = [[NSMutableDictionary alloc] init];
    [myItems setObject:[NSValue valueWithCGRect:cellOneRectangle] forKey:@"cellOneRectangle"];
    [myItems setObject:[NSValue valueWithCGRect:cellTwoRectangle] forKey:@"cellTwoRectangle"];
    [myItems setObject:[NSValue valueWithCGRect:cellThreeRectangle] forKey:@"cellThreeRectangle"];
    [myItems setObject:[NSValue valueWithCGRect:cellFourRectangle] forKey:@"cellFourRectangle"];
    [myItems setObject:[NSValue valueWithCGRect:cellFiveRectangle] forKey:@"cellFiveRectangle"];
    [myItems setObject:[NSValue valueWithCGRect:cellSixRectangle] forKey:@"cellSixRectangle"];
    [myItems setObject:[NSValue valueWithCGRect:cellSevenRectangle] forKey:@"cellSevenRectangle"];
    [myItems setObject:[NSValue valueWithCGRect:cellEightRectangle] forKey:@"cellEightRectangle"];
    [myItems setObject:[NSValue valueWithCGRect:cellNineRectangle] forKey:@"cellNineRectangle"];

}

-(void)boardColorUpdate:(NSInteger)index
{
    NSArray *visibleCellIndex = self.collectionView.indexPathsForVisibleItems;
    NSSortDescriptor *rowDescriptor = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
    NSArray *sortedVisibleCells = [visibleCellIndex sortedArrayUsingDescriptors:@[rowDescriptor]];
    [UIView animateWithDuration:.8 animations:^{
        [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[index]].backgroundColor = board.boardColors[index];
    }];
}

-(void)updateBoardColorV2:(CGPoint)loc
{
    //grab the cells
    //for every color on the board, check if the cell rectangle at the same index contains the point dropped in
    //if it does, change that cells backgroundcolor
    NSArray *visibleCellIndex = self.collectionView.indexPathsForVisibleItems;
    NSSortDescriptor *rowDescriptor = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
    NSArray *sortedVisibleCells = [visibleCellIndex sortedArrayUsingDescriptors:@[rowDescriptor]];
    UICollectionViewCell *cell;
    NSString *cellName;
    CGRect cellRect;
    //RFHGemImageContainer *gemContainer;
    for (int i = 0; i < [board.boardColors count]; i++) {
       // gemContainer = board.boardObjects[i];
        cell = [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[i]];
        cellName = [NSString stringWithFormat:@"cell%@Rectangle", [numberMappings objectForKey:[NSString stringWithFormat:@"%d", i+1]]];
        cellRect = [[myItems objectForKey:cellName] CGRectValue];
        if (CGRectContainsPoint(cellRect, loc)) {
            cell.backgroundColor = board.boardColors[i];
        }
    }
}

-(void)returnHome
{
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate performSelector:@selector(returnHome)];
}
-(void)resetGame
{
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate performSelector:@selector(resetGame)];
}

@end
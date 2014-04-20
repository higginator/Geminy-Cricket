//
//  RFHViewController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 4/12/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHViewController.h"
#import "RFHGemObject.h"
#import "RFHGameView.h"
#import "RFHGemImageContainer.h"
#import "RFHGameBoard.h"
#import "RFHHumanPlayer.h"
#import "RFHRobotPlayer.h"

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
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    board = [[RFHGameBoard alloc] init];
    board.boardObjects = [[NSMutableArray alloc] init];
    board.boardColors = [[NSMutableArray alloc] init];
    board.boardBools = [[NSMutableArray alloc] init];
    gemHand = [[NSMutableArray alloc] init];
    human = [[RFHHumanPlayer alloc] initWithName:@"RYGUY" Color:[UIColor orangeColor]];
    human.turn = YES;
    robotOpponent = [[RFHRobotPlayer alloc] initWithName:@"Robopponent" Color:[UIColor cyanColor]];
    [self initializeRobotGemHand];
    
    boardOffsetX = 10;
    boardOffsetY = 86;
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
    for (int i = 0; i < 6; i++) {
        [gemHand addObject:[RFHGemObject randomGem]];
    }
    NSLog(@"My View Did Load");
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 86, 300, 375)
                                             collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"boardCell"];
    self.collectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.collectionView];
    
    
    //initialize view objects
    int y = 498;
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
    self.gemOne.imageView.backgroundColor = [UIColor orangeColor];
    self.gemTwo.imageView.backgroundColor = [UIColor orangeColor];
    self.gemThree.imageView.backgroundColor = [UIColor orangeColor];
    self.gemFour.imageView.backgroundColor = [UIColor orangeColor];
    self.gemFive.imageView.backgroundColor = [UIColor orangeColor];
    self.gemSix.imageView.backgroundColor = [UIColor orangeColor];
    
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
    self.gemOne.gemOriginalCenter = CGPointMake(35, 523);
    self.gemTwo.gemOriginalCenter = CGPointMake(85, 523);
    self.gemThree.gemOriginalCenter = CGPointMake(135, 523);
    self.gemFour.gemOriginalCenter = CGPointMake(185, 523);
    self.gemFive.gemOriginalCenter = CGPointMake(235, 523);
    self.gemSix.gemOriginalCenter = CGPointMake(285, 523);
    
    // set gem's owner
    self.gemOne.owner = human;
    self.gemTwo.owner = human;
    self.gemThree.owner = human;
    self.gemFour.owner = human;
    self.gemFive.owner = human;
    self.gemSix.owner = human;
    
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
    NSLog(@"The location in the collection view is %f, %f", collectionLocation.x, collectionLocation.y);
    
    CGPoint location = [touch locationInView:touch.view];
    
    NSLog(@"THE LOCATION OF THE LAST TOUCH IS: %f, %f", location.x, location.y);
    // if my gem is not on the grid when I let go, send it back to it's original location
    CGRect collectionViewRect;
    collectionViewRect.origin = self.collectionView.frame.origin;
    collectionViewRect.size = self.collectionView.frame.size;
    //if gem not dropped on board, return the gem to gem Hand
    if (!CGRectContainsPoint(collectionViewRect, location)) {
        NSLog(@"Does Not contain point!!!");
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
                board.boardObjects[0] = touchedGem;
                board.boardColors[0] = touchedGem.owner.color;
                board.boardBools[0] = [NSNumber numberWithBool:YES];
                vacantCells[0] = [NSNull null];
                [self centerImage:touchedGem Rect:cellOneRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellTwoRectangle, collectionLocation)) {
                if ([board.boardBools[1] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                    touchedGem.imageView.center = touchedGem.gemOriginalCenter;
                } else {
                    touchedGem.onBoard = YES;
                    board.boardObjects[1] = touchedGem;
                    board.boardColors[1] = touchedGem.owner.color;
                    board.boardBools[1] = [NSNumber numberWithBool:YES];
                    vacantCells[1] = [NSNull null];
                    [self centerImage:touchedGem Rect:cellTwoRectangle];
                    [self boardCheck:touchedGem collectionLocation:collectionLocation];
                }
        } else if (CGRectContainsPoint(cellThreeRectangle, collectionLocation)) {
            if ([board.boardBools[2] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                board.boardObjects[2] = touchedGem;
                board.boardColors[2] = touchedGem.owner.color;
                board.boardBools[2] = [NSNumber numberWithBool:YES];
                vacantCells[2] = [NSNull null];
                [self centerImage:touchedGem Rect:cellThreeRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellFourRectangle, collectionLocation)) {
            if ([board.boardBools[3] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                board.boardObjects[3] = touchedGem;
                board.boardColors[3] = touchedGem.owner.color;
                board.boardBools[3] = [NSNumber numberWithBool:YES];
                vacantCells[3] = [NSNull null];
                [self centerImage:touchedGem Rect:cellFourRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellFiveRectangle, collectionLocation)) {
            if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                board.boardObjects[4] = touchedGem;
                board.boardColors[4] = touchedGem.owner.color;
                board.boardBools[4] = [NSNumber numberWithBool:YES];
                vacantCells[4] = [NSNull null];
                [self centerImage:touchedGem Rect:cellFiveRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellSixRectangle, collectionLocation)) {
            if ([board.boardBools[5] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                board.boardObjects[5] = touchedGem;
                board.boardColors[5] = touchedGem.owner.color;
                board.boardBools[5] = [NSNumber numberWithBool:YES];
                vacantCells[5] = [NSNull null];
                [self centerImage:touchedGem Rect:cellSixRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellSevenRectangle, collectionLocation)) {
            if ([board.boardBools[6] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                board.boardObjects[6] = touchedGem;
                board.boardColors[6] = touchedGem.owner.color;
                board.boardBools[6] = [NSNumber numberWithBool:YES];
                vacantCells[6] = [NSNull null];
                [self centerImage:touchedGem Rect:cellSevenRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellEightRectangle, collectionLocation)) {
            if ([board.boardBools[7] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                board.boardObjects[7] = touchedGem;
                board.boardColors[7] = touchedGem.owner.color;
                board.boardBools[7] = [NSNumber numberWithBool:YES];
                vacantCells[7] = [NSNull null];
                [self centerImage:touchedGem Rect:cellEightRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        } else if (CGRectContainsPoint(cellNineRectangle, collectionLocation)) {
            if ([board.boardBools[8] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                touchedGem.imageView.center = touchedGem.gemOriginalCenter;
            } else {
                touchedGem.onBoard = YES;
                board.boardObjects[8] = touchedGem;
                board.boardColors[8] = touchedGem.owner.color;
                board.boardBools[8] = [NSNumber numberWithBool:YES];
                vacantCells[8] = [NSNull null];
                [self centerImage:touchedGem Rect:cellNineRectangle];
                [self boardCheck:touchedGem collectionLocation:collectionLocation];
            }
        }

        [self changeTurnOrder];
        
        if ([self isGameOver]) {
            [self declareWinner];
        } else {
            [self robotMakeTurn];
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
    cell.backgroundColor = [UIColor greenColor];
    
    
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



#pragma mark - Custom Game Functions

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
    while (!cell) {
        cellIndex = arc4random_uniform((uint32_t)[vacantCells count]);
        if (vacantCells[cellIndex] != [NSNull null]) {
            cell = vacantCells[cellIndex];
            board.boardColors[cellIndex] = robotOpponent.color;
            board.boardBools[cellIndex] = [NSNumber numberWithBool:YES];
        }
    }
    while (!gem) {
        int index = arc4random() % [robotGemHand count];
        if (robotGemHand[index]) {
            gem = robotGemHand[index];
        }
    }
    RFHGemImageContainer *robotGemImage = [[RFHGemImageContainer alloc] initRobotGemContainer:gem Player:robotOpponent onBoard:YES];
    board.boardObjects[cellIndex] = robotGemImage;
    vacantCells[cellIndex] = [NSNull null];
    
    moveCount++;
    [self updateBoardColorV2:cell.center];
    [self changeTurnOrder];
    
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
    int humanTotal = 0;
    for (RFHGemImageContainer *gemContainer in board.boardObjects) {
        NSLog(@"THERE IS A GEM");
        if (gemContainer.gem.color == human.color) {
            NSLog(@"GEM COLORS ARE EQUAL");
            humanTotal++;
        }
    }
    NSLog(@"human total is %@", humanTotal);
    if (humanTotal >= 5) {
        //create victory label, place on screen
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(110, 150, 180, 180)];
        label.text = @"VICTORY";
        label.textColor = [UIColor colorWithRed:.22 green:.8 blue:.33 alpha:1.0];
        label.font = [label.font fontWithSize:25];
        [self.view addSubview:label];
    } else {
        //create defeat label, place on screen
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 240, 200, 200)];
        label.text = @"DEFEAT";
        label.textColor = [UIColor colorWithRed:.8 green:.22 blue:.1 alpha:1.0];
        label.font = [label.font fontWithSize:25];
        [self.view addSubview:label];
    }

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
                board.boardObjects[3] = sender.owner.color;
                [self boardColorUpdate:3];
            }
        }
    } else if ([board.boardObjects indexOfObject:sender] == 1) {
        //check board[0] and board[2] and board[3]
        if ([board.boardBools[0] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[0];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[0] = sender.owner.color;
                [self boardColorUpdate:0];
            }
        }
        if ([board.boardBools[2] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[2];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[2] = sender.owner.color;
                [self boardColorUpdate:2];
            }
        }
        if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[4];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[4] = sender.owner.color;
                [self boardColorUpdate:4];
            }
        }
        
    } else if ([board.boardObjects indexOfObject:sender] == 2) {
        //check board[1] and board[5]
        if ([board.boardBools[1] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[1];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[1] = sender.owner.color;
                [self boardColorUpdate:1];
            }
        }
        if ([board.boardBools[5] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[5];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[5] = sender.owner.color;
                [self boardColorUpdate:5];
            }
        }
        
    } else if ([board.boardObjects indexOfObject:sender] == 3) {
        //check board[0] and board[4] and board[6]
        if ([board.boardBools[0] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[0];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[0] = sender.owner.color;
                [self boardColorUpdate:0];
            }
        }
        if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[4];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[4] = sender.owner.color;
                [self boardColorUpdate:4];
            }
        }
        if ([board.boardBools[6] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[6];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[6] = sender.owner.color;
                [self boardColorUpdate:6];
            }
        }
        
    }  else if ([board.boardObjects indexOfObject:sender] == 4) {
        //check board[1] and board[3] and board[5] and board[7]
        if ([board.boardBools[1] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[1];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[1] = sender.owner.color;
            }
        }
        if ([board.boardBools[3] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[3];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[3] = sender.owner.color;
            }
        }
        if ([board.boardBools[5] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[5];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[5] = sender.owner.color;
            }
        }
        if ([board.boardBools[7] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[7];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[7] = sender.owner.color;
            }
        }
        
    } else if ([board.boardObjects indexOfObject:sender] == 5) {
        //check board[2] and board[4] and board[8]
        if ([board.boardBools[2] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[2];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[2] = sender.owner.color;
            }
        }
        if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[4];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[4] = sender.owner.color;
            }
        }
        if ([board.boardBools[8] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[8];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[8] = sender.owner.color;
            }
        }
        
    } else if ([board.boardObjects indexOfObject:sender] == 6) {
        //check board[3] and board[7]
        if ([board.boardBools[3] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[3];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[3] = sender.owner.color;
            }
        }
        if ([board.boardBools[7] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[7];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[7] = sender.owner.color;
            }
        }
    }  else if ([board.boardObjects indexOfObject:sender] == 7) {
        //check board[6] and board[4] and board[8]
        if ([board.boardBools[6] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[6];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[6] = sender.owner.color;
            }
        }
        if ([board.boardBools[4] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[4];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[4] = sender.owner.color;
            }
        }
        if ([board.boardBools[8] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[8];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[8] = sender.owner.color;
            }
        }
    } else if ([board.boardObjects indexOfObject:sender] == 8) {
        //check board[5] and board[7]
        if ([board.boardBools[5] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[5];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[5] = sender.owner.color;
            }
        }
        if ([board.boardBools[7] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            RFHGemImageContainer *comparisonGem = board.boardObjects[7];
            if (sender.gem.value > comparisonGem.gem.value) {
                board.boardObjects[7] = sender.owner.color;
            }
        }
    }
    moveCount++;
    NSLog(@"Movecount is %ld", moveCount);
    [self updateBoardColorV2:loc];
}

-(void)initializeRobotGemHand
{
    robotGemHand = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i++) {
        [robotGemHand addObject:[RFHGemObject randomGem]];
    }
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
    NSLog(@"Origin of rect 1 is %f %f and size of rect is %f %f", cellOneRectangle.origin.x, cellOneRectangle.origin.y, cellOneRectangle.size.width, cellOneRectangle.size.height);
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
    [self.collectionView cellForItemAtIndexPath:sortedVisibleCells[index]].backgroundColor = board.boardColors[index];
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

@end
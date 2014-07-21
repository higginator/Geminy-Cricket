//
//  RFHGameHistoryController.m
//  Geminy Cricket
//
//  Created by Ryan Higgins on 7/15/14.
//  Copyright (c) 2014 Higgnet. All rights reserved.
//

#import "RFHGameHistoryController.h"
#import "RFHCompletedGame.h"
#import "RFHDetailGameCompletedViewController.h"
#import "RFHAppDelegate.h"

@interface RFHGameHistoryController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation RFHGameHistoryController

-(instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _completedGames = [[NSMutableArray alloc] init];
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"HISTORY";
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(dismissNC)];
        navItem.leftBarButtonItem = bbi;
    }
    
    return self;
}

-(void)dismissNC {
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    RFHAppDelegate *appDelegate = (RFHAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate performSelector:@selector(returnHome)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.completedGames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSMutableArray *games = self.completedGames;
    RFHCompletedGame *game = games[[games count] - 1 - indexPath.row];
    NSUInteger gameNumber = [self.completedGames indexOfObject:game] + 1;
    NSString *numberToString = [NSString stringWithFormat:@"%lu", (unsigned long)gameNumber];
    NSUInteger lengthOfGameNumber = [numberToString length];
    NSUInteger lengthOfStartOfText = 6;
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Game %lu: %@",(unsigned long)gameNumber, game.outcome]];
    [mutableString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, lengthOfStartOfText + lengthOfGameNumber)];
    NSUInteger length = [mutableString length] - lengthOfStartOfText - lengthOfGameNumber;
    if ([game.outcome isEqualToString:@"VICTORY"]) {
        [mutableString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(lengthOfStartOfText + lengthOfGameNumber, length)];
    } else {
        [mutableString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(lengthOfStartOfText + lengthOfGameNumber, length)];
    }
    cell.textLabel.attributedText = mutableString;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *games = self.completedGames;
    RFHCompletedGame *game = games[[games count] - 1 - indexPath.row];
    RFHDetailGameCompletedViewController *dvc = [[RFHDetailGameCompletedViewController alloc] initWithGame:game];
    [self.navigationController pushViewController:dvc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

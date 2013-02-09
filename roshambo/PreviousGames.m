//
//  PreviousGames.m
//  roshambo
//
//  Created by La Barge, John on 2/8/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import "PreviousGames.h"

@interface PreviousGames ()

@end

@implementation PreviousGames

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    if (self) {
        // Custom initialization
               

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    RoshamboAppDelegate * roshambo = (RoshamboAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext * moc = [roshambo managedObjectContext];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PreviousGame"];
    NSError *error;
    self.previousGames = [moc executeFetchRequest:request error:&error];
    
    NSLog(@"***** found %d previous games in db",self.previousGames.count);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [self.previousGames count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    PrevGameCell *cell = (PrevGameCell * )[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrevGameCell" owner:self options:nil];
    	    cell = (PrevGameCell *)[nib objectAtIndex:0];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    PreviousGame * prevGame = [self.previousGames objectAtIndex:[indexPath indexAtPosition:1]];
    NSLog(@"prevGame = %@ %@ %@ %@", [dateFormatter stringFromDate:prevGame.date], prevGame.player, prevGame.computer, prevGame.result);
    cell.winLoseOrTieLabel.text = prevGame.result;
    cell.dateLabel.text = [dateFormatter stringFromDate:prevGame.date];
    [cell.playerThrowImage setImage:[UIImage imageNamed:[prevGame.player stringByAppendingString:@".png"]]];
    [cell.computerThrowImage setImage:[UIImage imageNamed:[prevGame.computer stringByAppendingString:@".png"]]];
    

    
    // Configure the cell...
    
    return cell;
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 155.0;
}
@end

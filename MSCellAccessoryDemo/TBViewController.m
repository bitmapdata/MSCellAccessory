//
//  TBViewController.m
//  MSCellAccessoryDemo
//
//  Created by SHIM MIN SEOK on 13. 6. 19..
//  Copyright (c) 2013 SHIM MIN SEOK. All rights reserved.
//

#import "TBViewController.h"
#import "MSCellAccessory.h"

@interface TBViewController ()

@end

@implementation TBViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if(indexPath.row == 0)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:253/255.0 green:184/255.0 blue:0/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 1)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:132/255.0 green:100/255.0 blue:159/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 2)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:0/255.0 green:166/255.0 blue:149/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 3)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 4)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:234/255.0 green:87/255.0 blue:123/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 5)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:35/255.0 green:110/255.0 blue:216/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 6)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:128/255.0 green:0/255.0 blue:64/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 7)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:0/255.0 green:128/255.0 blue:0/255.0 alpha:1.0]];

    }
    else if(indexPath.row == 8)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:175/255.0 green:106/255.0 blue:0/255.0 alpha:1.0]];

    }
    else if(indexPath.row == 9)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:200/255.0 green:63/255.0 blue:67/255.0 alpha:1.0]];

    }
    else if(indexPath.row == 10)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:255/255.0 green:51/255.0 blue:102/255.0 alpha:1.0]];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

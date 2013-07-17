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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"MSCellAccessory / DETAL_DISCLOSURE";
        [self configureCell:cell indexPath:indexPath accessoryType:DETAIL_DISCLOSURE];
    }
    else if(indexPath.row == 1)
    {
        cell.textLabel.text = @"UITableViewCellAccessoryDetailDisclosureButton";
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    else if(indexPath.row == 2)
    {
        cell.textLabel.text = @"MSCellAccessory / DISCLOSURE_INDICATOR";
        [self configureCell:cell indexPath:indexPath accessoryType:DISCLOSURE_INDICATOR];
    }
    else if(indexPath.row == 3)
    {
        cell.textLabel.text = @"UITableViewCellAccessoryDisclosureIndicator";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.row == 4)
    {
        cell.textLabel.text = @"MSCellAccessory / CHECKMARK";
        [self configureCell:cell indexPath:indexPath accessoryType:CHECKMARK];
    }
    else if(indexPath.row == 5)
    {
        cell.textLabel.text = @"UITableViewCellAccessoryCheckmark";
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if(indexPath.row == 6)
    {
        cell.textLabel.text = @"MSCellAccessory / TOGGLE_INDICATOR";
        [self configureCell:cell indexPath:indexPath accessoryType:TOGGLE_INDICATOR];
        MSCellAccessory *acc = (MSCellAccessory *)cell.accessoryView;
        acc.selected = true;
    }
    else if(indexPath.row == 7)
    {
        cell.textLabel.text = @"MSCellAccessory / TOGGLE_INDICATOR";
        [self configureCell:cell indexPath:indexPath accessoryType:TOGGLE_INDICATOR];
        MSCellAccessory *acc = (MSCellAccessory *)cell.accessoryView;
        acc.selected = false;
    }
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath accessoryType:(AccessoryType )accessoryType
{
    if(indexPath.row == 0)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:35/255.0 green:110/255.0 blue:216/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 1)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:132/255.0 green:100/255.0 blue:159/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 2)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 3)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 4)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:50/255.0 green:79/255.0 blue:133/255.0 alpha:1.0] highlightedColor:[UIColor whiteColor]];
    }
    else if(indexPath.row == 5)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:35/255.0 green:110/255.0 blue:216/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 6)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:0/255.0 green:123/255.0 blue:170/255.0 alpha:1.0]];
    }
    else if(indexPath.row == 7)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:0/255.0 green:123/255.0 blue:170/255.0 alpha:1.0]];
        
    }
    else if(indexPath.row == 8)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:175/255.0 green:106/255.0 blue:0/255.0 alpha:1.0]];
        
    }
    else if(indexPath.row == 9)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:200/255.0 green:63/255.0 blue:67/255.0 alpha:1.0]];
        
    }
    else if(indexPath.row == 10)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:255/255.0 green:51/255.0 blue:102/255.0 alpha:1.0]];
        
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.row == 6 || indexPath.row == 7)
    {
        MSCellAccessory *tmp = (MSCellAccessory *)cell.accessoryView;
        tmp.selected =! tmp.selected;
    }
}

@end

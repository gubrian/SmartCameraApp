//
//  selectorController.m
//  SmartCamera
//
//  Created by gubrian on 3/11/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import "selectorController.h"

@interface selectorController ()

@end

@implementation selectorController

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
    _arrItems = [[NSArray alloc] initWithObjects:@"Face Detection",@"Eye Detection",@"Mouth Detection", @"Face Detection LBP", nil];
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
   
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

    return [_arrItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_arrItems objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    embeddedViewController *myVC1ref = (embeddedViewController *)([self.tabBarController.viewControllers objectAtIndex:0]);
    NSString *text = [_arrItems objectAtIndex:indexPath.row];
    [myVC1ref changeDetection:text];
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
}

@end

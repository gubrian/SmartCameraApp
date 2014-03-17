//
//  selectorController.h
//  SmartCamera
//
//  Created by gubrian on 3/11/14.
//  Copyright (c) 2014 gubrian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "embeddedViewController.h"

@interface selectorController : UITableViewController
@property (nonatomic,strong) NSArray *arrItems;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

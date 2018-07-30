//
//  EmployeeViewController.h
//  MyStore
//
//  Created by ensor_mac on 22/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Employee+CoreDataClass.h"
#import "DetailViewController.h"

@interface EmployeeViewController : UITableViewController

@property (retain,nonatomic) NSMutableArray *employeeCollection;
@property(weak,nonatomic)AppDelegate *appDelegate;
@end

//
//  JobViewController.h
//  MyEmployee
//
//  Created by ensor_mac on 27/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface JobViewController : UITableViewController

@property(weak,nonatomic)AppDelegate *appDelegate;
@property (retain,nonatomic) NSMutableArray *jobCollection;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

- (IBAction)addJob:(id)sender;

@end

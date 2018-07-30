//
//  DetailViewController.h
//  MyStore
//
//  Created by ensor_mac on 22/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface DetailViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView *picker;
}

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtContactNo;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtJob;

@property(weak,nonatomic)AppDelegate *appDelegate;
@property(strong) NSManagedObject *employee;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end

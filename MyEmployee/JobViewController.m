//
//  JobViewController.m
//  MyEmployee
//
//  Created by ensor_mac on 27/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//

#import "JobViewController.h"
#import "Job+CoreDataProperties.h"

@interface JobViewController ()

@end

@implementation JobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self FetchDataFromDataBase];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Job"];
    self.jobCollection = [[_appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"count job=%ld", (unsigned long)self.jobCollection.count);
    
     [_mTableView reloadData];
}

-(void)FetchDataFromDataBase
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Job"];
    self.jobCollection = [[_appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"count job=%ld", (unsigned long)self.jobCollection.count);
    
    [_mTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jobCollection.count;
}

-(void)insertDataIntoDataBaseWithDescription:(NSString *)title WithDescription:(NSString *)description
{
    Job* item = [NSEntityDescription insertNewObjectForEntityForName:@"Job"  inManagedObjectContext:_appDelegate.managedObjectContext];
    item.jobTitle = title;
    item.jobDescription = description;
    
    NSError *error = nil;
    if ([_appDelegate.managedObjectContext save:&error]) {
        NSLog(@"data saved");
        [_appDelegate saveContext];
        [self.jobCollection addObject:item];
        [_mTableView reloadData];
    }
    else{
        NSLog(@"Error occured while saving");
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellJob" forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellJob"];
    }
    Job  *item = [self.jobCollection objectAtIndex:indexPath.row];
    [cell.textLabel setText:item.jobTitle];
    [cell.detailTextLabel setText:item.jobDescription];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *objectToDelete = [self.jobCollection objectAtIndex:indexPath.row];
        [_appDelegate.managedObjectContext deleteObject:objectToDelete];
        
        NSError *error;
        [_appDelegate.managedObjectContext save:&error];
        if (error) {
            NSLog(@"Could not save managed object context due to error : %@", error);
        } else {
            [self.jobCollection removeObject:objectToDelete];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
     /*
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
      */
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addJob:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Titre et Description" message: nil  preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"title";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"description";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    UIAlertAction* save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        //action save
        NSString *title = alertController.textFields[0].text;
        NSString *description = alertController.textFields[1].text;
        [self insertDataIntoDataBaseWithDescription:title WithDescription:description];
        NSLog(@"text was %@ - %@ ", title, description);
         [self.mTableView reloadData];
        }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //action cancel
            NSLog(@"cancel btn");
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
    
    [alertController addAction:cancel];
    [alertController addAction:save];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_appDelegate saveContext];
}

@end

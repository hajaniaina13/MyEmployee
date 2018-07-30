//
//  DetailViewController.m
//  MyStore
//
//  Created by ensor_mac on 22/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//

#import "DetailViewController.h"
#import "Employee+CoreDataProperties.h"
#import "Job+CoreDataProperties.h"

@interface DetailViewController (){
    NSMutableArray *jobCollection;
    NSManagedObject *jobSelected;
}

@end

@implementation DetailViewController
@synthesize employee;

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
    if(self.employee){
        _txtName.text= [self.employee valueForKey:@"name"];
        _txtEmail.text= [self.employee valueForKey:@"email"];
        _txtContactNo.text= [self.employee valueForKey:@"contactNo"];
        _txtAddress.text= [self.employee valueForKey:@"address"];
        //fetch job
        Job *jobEmployee =[self.employee valueForKey:@"job"];
        _txtJob.text= jobEmployee.jobTitle;
    }
    [self.view addSubview:_txtJob];
    
    picker = [[UIPickerView alloc]init];
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Job"];
    jobCollection = [[_appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //displaying a toolbar
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    
    //items on toolbar (cancel and done)
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    */
    //create a flexibe space bar button item on toolbar
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:space, doneButton, nil];
    
    [toolBar setItems:toolbarItems];
    _txtJob.inputView = picker;
    _txtJob.inputAccessoryView = toolBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSError *error;
    NSManagedObject *objectToDelete, *objectChildren;
    if(self.employee){
        [self.employee setValue:_txtName.text forKey:@"name"];
        [self.employee setValue:_txtEmail.text forKey:@"email"];
        [self.employee setValue:_txtContactNo.text forKey:@"contactNo"];
        [self.employee setValue:_txtAddress.text forKey:@"address"];
        objectChildren = self.employee ;
    }else{
        Employee* item = [NSEntityDescription insertNewObjectForEntityForName:@"Employee"  inManagedObjectContext:_appDelegate.managedObjectContext];
        item.name=_txtName.text;
        item.email = _txtEmail.text;
        item.contactNo = _txtContactNo.text;
        item.address = _txtAddress.text;
        objectToDelete = item;
        objectChildren = item;
    }
    if(![_appDelegate.managedObjectContext save:&error]){
        // NSLog(@"Error= %ld", error.code );
         NSString *message =  [_appDelegate getErrorCode:error.code];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Validation" message:message preferredStyle:UIAlertControllerStyleAlert];
         [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil] ];
        if(objectToDelete){
             [_appDelegate.managedObjectContext deleteObject:objectToDelete];
        }
         [self presentViewController: alertController animated: YES completion: nil];
    }else {
        //One-To-Many relationship
        if(jobSelected && objectChildren){
            NSMutableSet *empl = [jobSelected mutableSetValueForKey:@"employee"];
            [empl addObject:objectChildren];
            if(![_appDelegate.managedObjectContext save:&error]){
                NSLog(@"Unable de save managed object context");
            }
        }
        //Save managed object context
        [_appDelegate saveContext];
        //clear input text
        _txtName.text=@"";
        _txtEmail.text=@"";
        _txtContactNo.text=@"";
        _txtAddress.text=@"";
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return jobCollection.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Job *item = [jobCollection objectAtIndex:row];
    return item.jobTitle;
    //return _pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Job *item = [jobCollection objectAtIndex:row];
    jobSelected = item;
    [_txtJob setText:item.jobTitle];
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
}

-(void)cancelTouched:(UIBarButtonItem *)sender{
    // hide the picker view
    [_txtJob resignFirstResponder];
    // perform some action
}

-(void)doneTouched:(UIBarButtonItem *)sender{
    // hide the picker view
    [_txtJob resignFirstResponder];
    // perform some action
}

-(void)cancel{
    [self.view endEditing:YES];
}

@end

//
//  Employee+CoreDataProperties.m
//  MyEmployee
//
//  Created by ensor_mac on 27/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//
//

#import "Employee+CoreDataProperties.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
}

@dynamic address;
@dynamic contactNo;
@dynamic creationDate;
@dynamic email;
@dynamic id;
@dynamic modificationDate;
@dynamic name;
@dynamic job;

@end

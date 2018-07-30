//
//  Job+CoreDataProperties.m
//  MyEmployee
//
//  Created by ensor_mac on 27/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//
//

#import "Job+CoreDataProperties.h"

@implementation Job (CoreDataProperties)

+ (NSFetchRequest<Job *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Job"];
}

@dynamic jobDescription;
@dynamic jobTitle;
@dynamic employee;

@end

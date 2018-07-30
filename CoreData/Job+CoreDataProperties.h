//
//  Job+CoreDataProperties.h
//  MyEmployee
//
//  Created by ensor_mac on 27/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//
//

#import "Job+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Job (CoreDataProperties)

+ (NSFetchRequest<Job *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *jobDescription;
@property (nullable, nonatomic, copy) NSString *jobTitle;
@property (nullable, nonatomic, retain) NSSet<Employee *> *employee;

@end

@interface Job (CoreDataGeneratedAccessors)

- (void)addEmployeeObject:(Employee *)value;
- (void)removeEmployeeObject:(Employee *)value;
- (void)addEmployee:(NSSet<Employee *> *)values;
- (void)removeEmployee:(NSSet<Employee *> *)values;

@end

NS_ASSUME_NONNULL_END

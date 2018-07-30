//
//  Employee+CoreDataProperties.h
//  MyEmployee
//
//  Created by ensor_mac on 27/07/2018.
//  Copyright © 2018 ensor_mac. All rights reserved.
//
//

#import "Employee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *contactNo;
@property (nullable, nonatomic, copy) NSDate *creationDate;
@property (nullable, nonatomic, copy) NSString *email;
@property (nonatomic) int64_t id;
@property (nullable, nonatomic, copy) NSDate *modificationDate;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Job *job;

@end

NS_ASSUME_NONNULL_END

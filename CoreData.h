//
//  CoreData.h
//  TEC_ToTD
//
//  Created by Derek Neely on 1/23/12.
//  Copyright (c) 2012 derekneely.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreData : NSObject

- (NSManagedObject *)saveData:(NSDictionary *)data forKey:(NSString *)key;
- (NSManagedObject *)fetchDataForKey:(NSString *)key;

- (NSManagedObject *)saveToEntity:(NSString *)entity values:(NSDictionary *)values;
- (NSManagedObject *)updateObject:(NSManagedObject *)managedObject withValues:(NSDictionary *)values;
- (NSArray *)fetchFromEntity:(NSString *)entity where:(NSString *)where;


- (id)convertObjectModel:(id)objectModel;

@end

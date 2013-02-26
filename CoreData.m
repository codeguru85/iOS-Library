//
//  CoreData.m
//  TEC_ToTD
//
//  Created by Derek Neely on 1/23/12.
//  Copyright (c) 2012 derekneely.com. All rights reserved.
//

#import "CoreData.h"

#import "AppDelegate.h"

@implementation CoreData

- (NSManagedObject *)saveData:(NSDictionary *)data forKey:(NSString *)key {
    NSError *error;
    
    NSLog(@"saveSettingsData:%@", data);
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data 
                                                       options:NSJSONWritingPrettyPrinted 
                                                         error:&error];
    
    //NSString *jsonString = [NSString stringWithFormat:@"%@", data];
    //NSString *jsonString = [NSString stringWithUTF8String:[jsonData bytes]];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonData = nil;

    NSLog(@"savingSettings: %@", jsonString);
    
    NSDictionary *settingsData = [NSDictionary dictionaryWithObjectsAndKeys:
                                  key, @"settings_key", 
                                  jsonString, @"settings_json", nil];
    
    NSManagedObject *settingsManagedObject = [self fetchSettingsDataForKey:key];
    jsonString = nil;
    
    if (settingsManagedObject != nil) {
        NSLog(@"Updating Settings Data");
        return [self updateObject:settingsManagedObject withValues:settingsData];
    } else {
        NSLog(@"Saving New Settings Data");
        return [self saveToEntity:@"Settings" values:settingsData];
    }
    
    return nil;
}

- (NSManagedObject *)fetchDataForKey:(NSString *)key {
    NSString *where = [NSString stringWithFormat:@"settings_key='%@'", key, nil];
    
    NSArray *settings = [self fetchFromEntity:@"Settings" where:where];
    
    if ([settings count] > 0) {
        return [settings objectAtIndex:0];
    }
    
    return nil;
}

- (NSManagedObject *)saveToEntity:(NSString *)entity values:(NSDictionary *)values {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:entity
                                                                   inManagedObjectContext:context];
    

    if (values != nil) {
        for (NSString *key in values) {
            NSLog(@"key: %@, value: %@", key, [values objectForKey:key]);
            [managedObject setValue:[values objectForKey:key] forKey:key];
        }
    }
        
    [context save:&error];
    
    return managedObject;
    
    //fetch the tips and delete them
    //NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Tips" inManagedObjectContext:context];
    //NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //[request setEntity:entityDescription];
    
    //NSArray *tipsFetch = [context executeFetchRequest:request error:&error];
    
    //for (NSManagedObject *tipsObject in tipsFetch) {
        //[context deleteObject:tipsObject];
    //}
    
    //[context save:&error];
    //[request release];
    
    //save new tips
    
}

- (NSManagedObject *)updateObject:(NSManagedObject *)managedObject withValues:(NSDictionary *)values {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    if (values != nil) {
        for (NSString *key in values) {
            [managedObject setValue:[values objectForKey:key] forKey:key];
        }
    }
    
    NSError *error;
    [context save:&error];
    
    NSLog(@"updateObject Error: %@", error);
    
    return managedObject;
}

- (NSArray *)fetchFromEntity:(NSString *)entity where:(NSString *)where {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    if (where != nil) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:where];
        [request setPredicate:predicate];
    }
    
    NSArray *fetch = [context executeFetchRequest:request error:&error];
    return fetch;
    
    //for (NSManagedObject *tipsObject in tipsFetch) {
    //[context deleteObject:tipsObject];
    //}
}

#pragma mark - Core Data Tools Methods

- (NSObject *)convertObjectModel:(NSObject *)objectModel {
    if ([objectModel isKindOfClass:[NSArray class]]) {
        NSMutableArray *convertedObjects = [[NSMutableArray alloc] init];
        
        for (NSManagedObject *managedObject in (NSArray *)objectModel) {
            NSDictionary *convertedObject = [self convertObjectModel:managedObject];
            [convertedObjects addObject:convertedObject];
        }
        
        return convertedObjects;
    }
    
    /*if ([objectModel isKindOfClass:[NSManagedObject class]]) {
        for (<#type *object#> in <#collection#>) {
            <#statements#>
        }
    }*/
    
    return nil;
}

- (void)saveTipsToCoreData:(NSString *)tipsJSON {
    /*TEC_ToTDAppDelegate *appDelegate = (TEC_ToTDAppDelegate *)[[UIApplication sharedApplication] delegate];
     NSManagedObjectContext *context = [appDelegate managedObjectContext];
     NSError *error;
     
     NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Tips" inManagedObjectContext:context];
     
     //fetch the tips and delete them
     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     [request setEntity:entityDescription];
     
     NSArray *tipsFetch = [context executeFetchRequest:request error:&error];
     
     for (NSManagedObject *tipsObject in tipsFetch) {
     [context deleteObject:tipsObject];
     }
     
     [context save:&error];
     [request release];
     
     //save new tips
     NSManagedObject *managedTipsObject = [NSEntityDescription insertNewObjectForEntityForName:@"Tips" 
     inManagedObjectContext:context];
     
     NSDate *saveDate = [NSDate date];
     
     [managedTipsObject setValue:tipsJSON forKey:@"tipsJSON"];
     [managedTipsObject setValue:saveDate forKey:@"saveDate"];
     
     [context save:&error];*/
}

//- (NSManagedObject *)save:(NSDictionary *)data forEn

@end

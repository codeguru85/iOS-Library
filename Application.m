//
//  Application.m
//  Coop Connections
//
//  Created by Derek Neely on 12/28/10.
//  Copyright 2010 derekneely.com. All rights reserved.
//

#import "Application.h"

static Application *sharedApplication = nil;

@implementation Application

#pragma mark - Singleton Methods

+ (Application *)sharedApplication {
    @synchronized(self){
        if(sharedApplication == nil){
            sharedApplication = [[self alloc] init];
        }
    }
	
	return sharedApplication;
}

- (id)init {
    if (self = [super init]) { }
    return self;
}

- (void)dealloc { }

@end

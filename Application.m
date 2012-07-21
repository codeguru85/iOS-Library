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

#pragma mark -
#pragma mark Singleton Methods

+ (Application *)sharedApplication {
	if(sharedApplication == nil){
		sharedApplication = [[super allocWithZone:NULL] init];
	}
	
	return sharedApplication;
}

+ (id)allocWithZone:(NSZone *)zone {
	return [[self sharedApplication] retain];
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

- (id)retain {
	return self;
}

- (unsigned)retainCount {
	return NSUIntegerMax;
}

- (void)release {
	//do nothing
}

- (id)autorelease {
	return self;
}

@end

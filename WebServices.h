//
//  WebServices.h
//  TEC_ToTD
//
//  Created by Derek Neely on 1/23/12.
//  Copyright (c) 2012 derekneely.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <netinet/in.h>

#define kRequestTimeoutInterval 30

#define BASE_URL        @"[DEFINE BASE URL]"

@protocol WebServicesDelegate <NSObject>

@optional
@end

@interface WebServices : NSObject { }

@property (nonatomic, assign) id <WebServicesDelegate> delegate;

#pragma mark - Generic Request Handler
- (void)makeRequestTo:(NSURL *)url withData:(NSData *)data forSuccess:(NSString *)successCallback forError:(NSString *)errorCallback;

#pragma mark - Network Connection Methods
+ (BOOL)connectedToNetwork;

#pragma mark - Init Methods
- (id)initWithDelegate:(id)delegateObj;

@end

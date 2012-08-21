//
//  WebServices.m
//  TEC_ToTD
//
//  Created by Derek Neely on 1/23/12.
//  Copyright (c) 2012 derekneely.com. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices

@synthesize delegate;

#pragma mark - Static Block Request Handler

+ (void)makeRequestTo:(NSURL *)url withRequestHeaders:(NSDictionary *)requestHeaders ofMethod:(NSString*)requestMethod withData:(NSData *)data onSuccess:(void (^)(NSData *))successBlock onError:(void (^)(NSError *))errorBlock {
    
    if ([WebServices connectedToNetwork]) {
        NSLog(@"Request URL: %@", url);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
		[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		
        for (NSString *key in requestHeaders) {
            [request setValue:[requestHeaders objectForKey:key] forHTTPHeaderField:key];
        }
        
        [request setHTTPMethod:requestMethod];
		
        if (data != nil) {
            [request setHTTPBody:data];
        }
        
		[NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue currentQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                                   if (data != nil) {
                                       successBlock(data);
                                       return;
                                   }
                                   
                                   if (error != nil) {
                                       errorBlock(error);
                                       return;
                                   }
                               }];
    } else {
        errorBlock(nil);
        return;
    }
}

#pragma mark - Generic Request Handler

- (void)makeRequestTo:(NSURL *)url withData:(NSData *)data forSuccess:(NSString *)successCallback forError:(NSString *)errorCallback {
    
    if ([WebServices connectedToNetwork]) {
        NSLog(@"Request URL: %@", url);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
		[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		[request setHTTPMethod: @"POST"];
		
        if (data != nil) {
            [request setHTTPBody:data];
        }
        
		[NSURLConnection sendAsynchronousRequest:request 
                                           queue:[NSOperationQueue currentQueue] 
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                                   if (data != nil) {
                                       if ([delegate respondsToSelector:NSSelectorFromString(successCallback)]) {
                                           //[delegate performSelector:successCallback withObject:data];
                                           objc_msgSend(delegate, NSSelectorFromString(successCallback), data);
                                       }
                                       return;
                                   }
                                   
                                   if (error != nil) {
                                       if ([delegate respondsToSelector:NSSelectorFromString(errorCallback)]) {
                                           //[delegate performSelector:errorCallback withObject:error];
                                           objc_msgSend(delegate, NSSelectorFromString(errorCallback), error);
                                       }
                                       return;
                                   }
                               }];
    } else {
        if ([delegate respondsToSelector:NSSelectorFromString(errorCallback)]) {
            //[delegate performSelector:errorCallback withObject:error];
            objc_msgSend(delegate, NSSelectorFromString(errorCallback), nil);
        }
        return;
    }
}

#pragma mark - Network Connection Methods

+ (BOOL)connectedToNetwork {
	struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
	
    if (!didRetrieveFlags){
        NSLog(@"Error. Could not recover network reachability flags\n");
        return 0;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
	
    return ((isReachable && !needsConnection) || nonWiFi) ? YES : NO;
}

#pragma mark - Init Methods

- (id)initWithDelegate:(id)delegateObj {
    if (self = [super init]) {
        self.delegate = delegateObj;
    }
    
    return self;
}

@end

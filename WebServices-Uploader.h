//
//  WebServices-Uploader.h
//  RIMulator
//
//  Created by Derek Neely on 1/6/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JSON.h"

@interface WebServices_Uploader : NSObject {

}

+ (NSDictionary *)uploadImageToServer:(NSDictionary *)imageInfo;
@end

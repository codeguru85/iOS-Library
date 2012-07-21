//
//  UIDevice+Identifier.h
//  TogetherWeSave - TEC
//
//  Created by Derek Neely on 2/6/12.
//  Copyright (c) 2012 derekneely.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIDevice (Identifier)

- (NSString *) uniqueDeviceIdentifier;
- (NSString *) uniqueGlobalDeviceIdentifier;

@end

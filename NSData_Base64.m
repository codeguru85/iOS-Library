//
//  NSData_Base64.m
//  Luhu
//
//  Created by Derek Neely on 3/26/13.
//  Copyright (c) 2013 Derek Neely. All rights reserved.
//

//#import "NSData_Base64.h"

static const char base64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSData (NSData_Base64)

- (NSString *)base64Encode {
    if ([self length] == 0) { return @""; }
    
    char *characters = malloc((([self length] + 2) / 3) * 4);
    if (characters == NULL) { return nil; }
    
    NSUInteger length = 0;
    NSUInteger i = 0;
    
    while (i < [self length]) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        
        while (bufferLength < 3 && i < [self length]) {
            buffer[bufferLength++] = ((char *)[self bytes])[i++];
        }
        
        characters[length++] = base64EncodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = base64EncodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        
        if (bufferLength > 1) {
            characters[length++] = base64EncodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        } else {
            characters[length++] = '=';
        }
        
        if (bufferLength > 2) {
            characters[length++] = base64EncodingTable[buffer[2] & 0x3F];
        } else {
            characters[length++] = '=';
        }
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end

//
//  WebServices-Uploader.m
//  RIMulator
//
//  Created by Derek Neely on 1/6/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import "WebServices-Uploader.h"


@implementation WebServices_Uploader

+ (NSDictionary *)uploadImageToServer:(NSDictionary *)imageInfo {
	//NSData *imageData = UIImageJPEGRepresentation(imageView.image,70);
	NSData *imageData = UIImageJPEGRepresentation((UIImage *)[imageInfo objectForKey:@"image"],100);
	
	//NSString *urlString = @"http://iphone.domain.net/upload_photos.aspx";
	NSString *urlString = @"http://gbd.vfourweb.com/rimulate_ws.php?method=post_image_facebook";
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
	
	NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n", 
					   [imageInfo objectForKey:@"image_name"]] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"message\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Test posting"] dataUsingEncoding:NSUTF8StringEncoding]];  // title
	
	//[body appendData:[[NSString stringWithFormat:@"?message=Test posting"] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[request setHTTPBody:body];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil ];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	NSLog(@"returnSTring: %@", returnString);
	
	NSDictionary *returnDictionary = [returnString JSONValue];
	[returnString release];
	
	return returnDictionary;
}

@end

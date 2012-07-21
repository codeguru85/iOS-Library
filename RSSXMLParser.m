//
//  RSSXMLParser.m
//  Comfort Zone Camp
//
//  Created by Derek Neely on 6/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import "RSSXMLParser.h"


@implementation RSSXMLParser

@synthesize anArticle, allArticles;
@synthesize currentElement;
@synthesize currentTitle, currentLink, currentDescription, currentDate, currentContent; 

#pragma mark -
#pragma mark XMLParser Delegate Methods

- (void)parserDidStartDocument:(NSXMLParser *)parser { 
    NSLog(@"found file and started parsing");
    allArticles = [[NSMutableArray alloc] init];
} 

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError { 
    NSString *errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]]; 
    NSLog(@"error parsing XML: %@", errorString); 
} 

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{ 
    
    currentElement = [elementName copy];
    
    if ([elementName isEqualToString:@"item"]) {
        anArticle = [[NSMutableDictionary alloc] init];
        
        currentTitle = [[NSMutableString alloc] init];
        currentLink = [[NSMutableString alloc] init];
        currentDescription = [[NSMutableString alloc] init]; 
        currentDate = [[NSMutableString alloc] init];
        currentContent = [[NSMutableString alloc] init];
    }
} 

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ 
    if ([elementName isEqualToString:@"item"]) { 
        [anArticle setObject:currentTitle forKey:@"title"]; 
        [anArticle setObject:currentLink forKey:@"link"]; 
        [anArticle setObject:currentDate forKey:@"date"]; 
        
        //HTMLParser *htmlParser = [[HTMLParser alloc] init];
        
        NSMutableString *tempCurrentDesc = [NSMutableString stringWithString:currentDescription];
        [tempCurrentDesc stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
        [tempCurrentDesc stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
        
        /*NSXMLParser *htmlXmlParser = [[NSXMLParser alloc] initWithData:[tempCurrentDesc dataUsingEncoding:NSUTF8StringEncoding]];
        [htmlXmlParser setDelegate:htmlParser];
        [htmlXmlParser parse];*/
        
        [anArticle setObject:tempCurrentDesc forKey:@"description"];
        
        [anArticle setObject:currentContent forKey:@"content"];
        
        //UIImage *articleImage = [self extractArticleImage:tempCurrentDesc];
        NSDictionary *articleImageData = [self extractArticleImage:tempCurrentDesc];
        
        if ([articleImageData objectForKey:@"image"] != [NSNull null]) {
            [anArticle setObject:[articleImageData objectForKey:@"image_url"] forKey:@"image_url"];
            [anArticle setObject:[articleImageData objectForKey:@"image"] forKey:@"image"];
        } else {
            [anArticle setObject:[articleImageData objectForKey:@"image_url"] forKey:@"image_url"];
            [anArticle setObject:[NSNull null] forKey:@"image"];
        }
        
        
        [allArticles addObject:[anArticle copy]]; 
        //NSLog(@"adding article: %@", currentTitle); 
    } 
} 

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{ 
    if ([currentElement isEqualToString:@"title"]) { 
        [currentTitle appendString:string]; 
    } else if ([currentElement isEqualToString:@"link"]) { 
        [currentLink appendString:string]; 
    } else if ([currentElement isEqualToString:@"description"]) { 
        [currentDescription appendString:string]; 
    } else if ([currentElement isEqualToString:@"pubDate"]) { 
        [currentDate appendString:string]; 
    } else if ([currentElement isEqualToString:@"content:encoded"]){
        [currentContent appendString:string];
    }
} 

- (void)parserDidEndDocument:(NSXMLParser *)parser { 
    NSLog(@"Did finish parsing document");
}

- (NSDictionary *)extractArticleImage:(NSString *)articleDesc {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"src=['\"]?([^\'\" >]+)" options:0 error:NULL];
    //NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    NSRange searchRange = NSMakeRange(0, [articleDesc length]);
    NSArray *regexMatches = [regex matchesInString:articleDesc options:NSMatchingWithTransparentBounds range:searchRange];
    
    NSLog(@"regexMatches: %@", regexMatches);
    
    if ([regexMatches count] > 0) {
        
        for (NSTextCheckingResult *checkResult in regexMatches){
            //NSLog(@"Check Result Range: %@", checkResult.range);
            NSString *resultString = [articleDesc substringWithRange:checkResult.range];
            NSLog(@"RESULTSTRING: %@ for: %@", resultString, articleDesc);
            
            if ([resultString rangeOfString:@".jpg"].location != NSNotFound){
                resultString = [resultString stringByReplacingOccurrencesOfString:@"src=" withString:@""];
                resultString = [resultString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
               // NSLog(@"string: %@", resultString);
                if ([resultString rangeOfString:@"//www.comfortzonecamp.org/"].location == NSNotFound){
                    resultString = [NSString stringWithFormat:@"http://www.comfortzonecamp.org%@", resultString];
                } else {
                    resultString = [resultString stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
                }
                
                NSLog(@"IMAGE URL: %@", resultString);
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:resultString]]];
                
                if (image == nil) {
                    return [NSDictionary dictionaryWithObjectsAndKeys:resultString, @"image_url",
                            [NSNull null], @"image",
                            nil];
                } else {
                    return [NSDictionary dictionaryWithObjectsAndKeys:resultString, @"image_url",
                            image, @"image",
                            nil];
                }
            }
        }
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"", @"image_url",
                [NSNull null], @"image",
                nil];;
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"", @"image_url",
            [NSNull null], @"image",
            nil];;
}

- (void)dealloc {
	/*[ttypesArray release];
	
	[currentElementValue release];
	*/
	[super dealloc];
}

@end

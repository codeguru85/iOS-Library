//
//  RSSXMLParser.m
//  Comfort Zone Camp
//
//  Created by Derek Neely on 6/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import "RSSXMLParser.h"


@implementation RSSXMLParser

@synthesize delegate, successCallback, errorCallback;
@synthesize allArticles;
@synthesize anArticle, currentElement;
@synthesize currentTitle, currentLink, currentDescription, currentDate, currentContent;

- (void)rssParserDidCompleteWithSuccess {
    if ([delegate respondsToSelector:NSSelectorFromString(successCallback)]) {
        objc_msgSend(delegate, NSSelectorFromString(successCallback), allArticles);
    }
}

- (void)rssParserDidFailWithError:(NSError *)error {
    if ([delegate respondsToSelector:NSSelectorFromString(errorCallback)]) {
        objc_msgSend(delegate, NSSelectorFromString(errorCallback), error);
    }
}

#pragma mark - XMLParser Delegate Methods

- (void)parserDidStartDocument:(NSXMLParser *)parser { 
    NSLog(@"parserDidStartDocument");
    allArticles = [[NSMutableArray alloc] init];
} 

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"parser parseError: %@", parseError);
    
    [self rssParserDidFailWithError:parseError];
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
        
        NSMutableString *tempCurrentDesc = [NSMutableString stringWithString:currentDescription];
        [tempCurrentDesc stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
        [tempCurrentDesc stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
        
        [anArticle setObject:tempCurrentDesc forKey:@"description"];
        
        [anArticle setObject:currentContent forKey:@"content"];
        
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
    NSLog(@"parserDidEndDocument");
    [self rssParserDidCompleteWithSuccess];
}

#pragma mark - Init Methods
 
- (id)initWithDelegate:(id)delegateObj {
    if (self = [super init]) {
        self.delegate = delegateObj;
    }
    
    return self;
}


@end

//
//  RSSXMLParser.h
//  Comfort Zone Camp
//
//  Created by Derek Neely on 6/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTMLParser.h"

@interface RSSXMLParser : NSObject <NSXMLParserDelegate> {
    NSMutableDictionary *anArticle;
	NSMutableArray      *allArticles;
	
    NSString            *currentElement;
	
    NSMutableString     *currentTitle;
    NSMutableString     *currentLink;
    NSMutableString     *currentDescription;
    NSMutableString     *currentDate;
    NSMutableString     *currentContent;
}

@property (nonatomic, retain) NSDictionary *anArticle;

@property (nonatomic, retain) NSMutableArray *allArticles;

@property (nonatomic, retain) NSString *currentElement;
@property (nonatomic, retain) NSMutableString *currentTitle;
@property (nonatomic, retain) NSMutableString *currentLink;
@property (nonatomic, retain) NSMutableString *currentDescription;
@property (nonatomic, retain) NSMutableString *currentDate; 
@property (nonatomic, retain) NSMutableString *currentContent;

- (NSDictionary *)extractArticleImage:(NSString *)articleDesc;

@end

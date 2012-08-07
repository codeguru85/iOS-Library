//
//  RSSXMLParser.h
//  Comfort Zone Camp
//
//  Created by Derek Neely on 6/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

@interface RSSXMLParser : NSObject <NSXMLParserDelegate> {
    NSString *successCallback;
    NSString *errorCallback;
    
    NSMutableArray      *allArticles;
    
    NSMutableDictionary *anArticle;
    NSString            *currentElement;
    NSMutableString     *currentTitle;
    NSMutableString     *currentLink;
    NSMutableString     *currentDescription;
    NSMutableString     *currentDate;
    NSMutableString     *currentContent;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSString *successCallback;
@property (nonatomic, retain) NSString *errorCallback;

@property (nonatomic, retain) NSMutableArray *allArticles;

@property (nonatomic, retain) NSDictionary *anArticle;
@property (nonatomic, retain) NSString *currentElement;
@property (nonatomic, retain) NSMutableString *currentTitle;
@property (nonatomic, retain) NSMutableString *currentLink;
@property (nonatomic, retain) NSMutableString *currentDescription;
@property (nonatomic, retain) NSMutableString *currentDate; 
@property (nonatomic, retain) NSMutableString *currentContent;

#pragma mark - Init Methods

- (id)initWithDelegate:(id)delegateObj;

@end

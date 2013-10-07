//
//  RssParserTest.m
//  VnexpressRssFeed
//
//  Created by Coder on 9/17/13.
//  Copyright (c) 2013 iOSTraining. All rights reserved.
//

#import "RssParserTest.h"
#import "RssParser.h"
#import "NewsItem.h"

@implementation RssParserTest
-(void)setUp
{
    [super setUp];
}

-(void)tearDown
{
    [super tearDown];
}

-(void)test_CreateInstance_NotNull
{
    RssParser *obj = [[RssParser alloc] init];
    STAssertNotNil(obj, @"RssParse instance can not be created !!!");
}

-(void)test_ParseItem_ReturnNotNull
{
    NewsItem *newsItem = nil;
    RssParser *parser = [[RssParser alloc] init];
    newsItem = [parser parse:@""];
    STAssertNotNil(newsItem, @"news item is null after parsing !!!");
}


@end

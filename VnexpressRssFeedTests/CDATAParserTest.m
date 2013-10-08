//
//  CDATAParserTest.m
//  VnexpressRssFeed
//
//  Created by Coder on 10/8/13.
//  Copyright (c) 2013 iOSTraining. All rights reserved.
//

#import "CDATAParserTest.h"
#import "CDATAParser.h"

@implementation CDATAParserTest

NSString *data;
CDATAParser *parser;

-(void) setUp
{
    [super setUp];
    data  = @"<a href=\"http://giaitri.vnexpress.net/tin-tuc/thoi-trang/lang-mot/thoi-trang-cua-sao-hollywood-nhung-nam-1990-2891646.html\"><img width=130 height=100 src=\"http://s.f12.img.vnexpress.net/2013/10/08/sao6-7379-1381200635-6773-1381204347_130x100.jpg\" ></a></br>Các sao thời kỳ này thường chuộng những trang phục cầu kỳ, rườm rà và màu sắc.";
    parser = [[CDATAParser alloc] initWithString:data];
}

-(void) tearDown
{
    [super tearDown];
}

-(void) test_Create_Instance_Not_null
{
    CDATAParser *o = [[CDATAParser alloc] init];
    STAssertNotNil(o, @"Create instance should be ok!!");
}

-(void) test_Create_Instance_with_customized_initializer
{
    CDATAParser *o = [[CDATAParser alloc] initWithString:@""];
    STAssertNotNil(o, @"Initialize object with customized initializer should be ok");
}

-(void) test_Get_thumbnail_url
{
    NSString *thumbnail = [parser getThumbnailUrl];
    STAssertNotNil(thumbnail, @"Thumbnail should be not null");
}

-(void) test_Get_headline
{
    NSString *headline = [parser getHeadline];
    STAssertNotNil(headline, @"Headline should be not null");
}

-(void) test_Evaluate_value_thumb_url
{
    NSString *thumbUrl = [parser getThumbnailUrl];
    NSLog(@"%@", thumbUrl);
//    STAssertEquals(@"http://s.f12.img.vnexpress.net/2013/10/08/sao6-7379-1381200635-6773-1381204347_130x100.jpg", thumbUrl, @"let is be !!!");
    STAssertEqualObjects(@"http://s.f12.img.vnexpress.net/2013/10/08/sao6-7379-1381200635-6773-1381204347_130x100.jpg", thumbUrl, @"let it be ");
}

@end

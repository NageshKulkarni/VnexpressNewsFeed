
//
//  CDATAParser.m
//  VnexpressRssFeed
//
//  Created by Coder on 10/8/13.
//  Copyright (c) 2013 iOSTraining. All rights reserved.
//

#import "CDATAParser.h"

@implementation CDATAParser

-(CDATAParser *)initWithString:(NSString *)string
{
    self = [super init];
    if(self)
    {
        data = string;
    }
    return self;
}

-(NSString *)getThumbnailUrl
{
    NSScanner *scanner = [NSScanner scannerWithString:data];
    [scanner scanUpToString:@"src=\"" intoString:nil];
    [scanner scanString:@"src=\"" intoString:nil];
    NSString *imageUrl = [[NSString alloc] init];
    [scanner scanUpToString:@"\"" intoString:&imageUrl];
    return imageUrl;
}

-(NSString *)getHeadline
{
    NSRange range = [data rangeOfString:@"</a></br>"];
    if (range.location != NSNotFound) {
        NSString *newString = [data substringFromIndex:range.location + range.length];
        return newString;
    }
    return @"";
}

@end

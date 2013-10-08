//
//  CDATAParser.h
//  VnexpressRssFeed
//
//  Created by Coder on 10/8/13.
//  Copyright (c) 2013 iOSTraining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDATAParser : NSObject
{
    NSString *data;
}

-(CDATAParser *) initWithString: (NSString *)string;

-(NSString *) getThumbnailUrl;

-(NSString *) getHeadline;


@end

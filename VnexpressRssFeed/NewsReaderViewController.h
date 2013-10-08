//
//  NewsReaderViewController.h
//  VnexpressRssFeed
//
//  Created by Coder on 10/8/13.
//  Copyright (c) 2013 iOSTraining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsReaderViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    BOOL isLoading;
    UIActivityIndicatorView *indicatorView;
}

@property NSString *link;

@end

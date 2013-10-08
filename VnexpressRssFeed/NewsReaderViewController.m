//
//  NewsReaderViewController.m
//  VnexpressRssFeed
//
//  Created by Coder on 10/8/13.
//  Copyright (c) 2013 iOSTraining. All rights reserved.
//

#import "NewsReaderViewController.h"

@interface NewsReaderViewController ()

@end

@implementation NewsReaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeViews];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (isLoading) [webView stopLoading];
}


-(void)viewDidDisappear:(BOOL)animated
{
    webView = nil;
    [super viewDidDisappear:animated];
}


#pragma mark - webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [indicatorView startAnimating];
    isLoading = true;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [indicatorView stopAnimating];
    isLoading = false;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - private methods
-(void) initializeViews
{
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake([[UIScreen mainScreen] applicationFrame].size.width/2, [[UIScreen mainScreen] applicationFrame].size.height/2)];
    [self.view addSubview:indicatorView];
}

@end

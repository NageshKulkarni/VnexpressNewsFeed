//
//  MMViewController.h
//  VnexpressRssFeed
//
//  Created by Coder on 9/17/13.
//  Copyright (c) 2013 iOSTraining. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItemCell.h"

@interface MMViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, NSXMLParserDelegate>
{
    IBOutlet NewsItemCell *myCell;    
    NSMutableArray *tableData;
    NSMutableData *responseData;
    UIActivityIndicatorView *indicatorView;
    IBOutlet UITableView *tableview;
    
    UIButton *rightButton;
}
@end

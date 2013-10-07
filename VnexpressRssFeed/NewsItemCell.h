//
//  NewsItemCell.h
//  VnexpressRssFeed
//
//  Created by Coder on 9/17/13.
//  Copyright (c) 2013 iOSTraining. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"

@interface NewsItemCell : UITableViewCell
{
    IBOutlet UILabel *title;
    IBOutlet UILabel *description;
    IBOutlet UIImageView *thumbnail;
}
-(void)setRowData: (NewsItem *)item;

@end

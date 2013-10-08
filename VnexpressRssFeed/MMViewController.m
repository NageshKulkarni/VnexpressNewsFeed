//
//  MMViewController.m
//  VnexpressRssFeed
//
//  Created by Coder on 9/17/13.
//  Copyright (c) 2013 iOSTraining. All rights reserved.
//

#import "MMViewController.h"
#import "CommonData.h"
#import "NewsReaderViewController.h"

@interface MMViewController ()
{
    NewsItem *item;
    NSMutableArray *items;
    NSMutableString *currentItemValue;
    NSString *lastElementName;
}
@end

@implementation MMViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"News Feed";
    [self initializeComponents];
    [self getFeedData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - TableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";
    NewsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"NewsItemCell" owner:self options:nil];
        cell = myCell;
    }
    NewsItem *item1 = (NewsItem*)[tableData objectAtIndex:indexPath.row];
    [cell setRowData:item1];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select row at %i - %i", indexPath.row, indexPath.section);
    NewsReaderViewController *newsReaderViewController = [[NewsReaderViewController alloc] initWithNibName:@"NewsReaderViewController" bundle:nil];
    NewsItem *newsItem = [tableData objectAtIndex:indexPath.row];
    newsReaderViewController.navigationItem.title = newsItem.title;
    newsReaderViewController.link = newsItem.link;
    [self.navigationController pushViewController:newsReaderViewController animated:YES];
}

#pragma mark - NSURLConnection delegate method
- (void)connection:(NSConnection*) connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"connection didReceiveResponse");
}

- (void)connection:(NSConnection*) connection didReceiveData:(NSData *)data
{
    NSLog(@"connection didReceiveData");
    [responseData appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection*) connection
{
    NSLog(@"connectionDidFinishLoading");
    [indicatorView stopAnimating];
    NSLog(@"%@", [NSString stringWithFormat:@"size of downloaded file is %d bytes", responseData.length]);
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseData];
    [parser setDelegate:self];
    [parser parse];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection didFailWithError");
}

#pragma mark - NSXMLParse delegate methods

static NSString *TITLE = @"title";
static NSString *ITEM = @"item";
static NSString *CHANNEL = @"channel";
//static NSString *DESC = @"description";
static NSString *UPDATED = @"updated";
static NSString *LINK = @"link";

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:ITEM])
    {
        lastElementName = elementName;
        item = [[NewsItem alloc] init];
    }
}


-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!currentItemValue)
    {
        currentItemValue = [[NSMutableString alloc] initWithString:string];
    } else
    {
        [currentItemValue appendString:string];
    }
}

-(void) parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    NSString *cData = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    [item setValue:cData forKey:@"desc"];
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:CHANNEL])
    {
        // end of list
        NSLog(@"%i items", [items count]);
        tableData = items;
        [tableview reloadData];
        return;
    }
    else if([elementName isEqualToString:ITEM])
    {
        [items addObject:item];
        item = nil;
    }
    else
    {
        NSString *normalizedText = [[currentItemValue stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([elementName isEqualToString:TITLE])
        {
            [item setValue:normalizedText forKey:TITLE];
        }
        else if([elementName isEqualToString:UPDATED])
        {
            [item setValue:normalizedText forKey:UPDATED];
        }
        else if([elementName isEqualToString:LINK])
        {
            [item setValue:normalizedText forKey:LINK];
        }
        
        currentItemValue = nil;

    }
}


#pragma mark - private methods
- (void) initializeComponents
{
    // init datasource with empty array
    tableData = [NSArray array];
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake([[UIScreen mainScreen] applicationFrame].size.width/2, [[UIScreen mainScreen] applicationFrame].size.height/2)];
    responseData = [NSMutableData data];
    [self.view addSubview:indicatorView];
    items = [[NSMutableArray alloc] init];
                                            
}

- (void)getFeedData
{
    // create the request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:DATA_URL]];
    NSURLConnection *connecion = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [indicatorView startAnimating];
    [connecion start];
}


@end


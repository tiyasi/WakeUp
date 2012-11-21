//
//  NewsController.m
//  WakeUp
//
//  Created by Tiyasi on 8/11/12.
//  Copyright (c) 2012 Tiyasi. All rights reserved.
//

#import "NewsController.h"
#import "JSON/JSON.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"

@interface NewsController ()
{
    UITableView *tabView;
    NSXMLParser *xmlParser1;
    NSMutableArray *titArray;
    NSString *titleString;
    NSMutableString *muttitle;
    NSMutableString *mutstrlink;
    NSString *classElement;
    BOOL itemSelected;
    NSMutableArray *linkArray;
    UIWebView *detailView;
    NSMutableData *responseData;
}
@end

@implementation NewsController

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

    [self.view setBackgroundColor:[UIColor clearColor]];
    [self setTitle:@"Top Stories"];
  
    titleString=[[NSString alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
    tabView=[[UITableView alloc]initWithFrame:[self.view bounds]];
    [tabView setBackgroundColor:[UIColor clearColor]];
    [tabView setDelegate:self];
    [tabView setDataSource:self];
    [self.view addSubview:tabView];
    [tabView release];
    
    [self loadData];

}

-(void)loadData
{
    // Construct the web service URL
    NSURL *url = [NSURL URLWithString:@"http://in.news.yahoo.com/rss/"]; 
    titArray=[[NSMutableArray alloc]init];
    linkArray=[[NSMutableArray alloc]init];
        
    xmlParser1=[[NSXMLParser alloc]initWithContentsOfURL:url];
    [xmlParser1 setDelegate:self];
    [xmlParser1 parse];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    classElement=elementName;
    
    if([elementName isEqualToString:@"title"]&& itemSelected==NO)
    {
        itemSelected =YES;
        muttitle=[[NSMutableString alloc]init];
    }
    
    if ([elementName isEqualToString:@"link"])
    {
        itemSelected =YES;
        mutstrlink=[[NSMutableString alloc]init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //These are the headlines
    [muttitle appendString:string];
    
    //Link to each title
    [mutstrlink appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    classElement=elementName;
    
    if([elementName isEqualToString:@"title"]&&itemSelected==YES)
    {
        itemSelected =NO;
        titleString=muttitle;
        NSString *yahooString= @"Yahoo! India News";
        NSRange range = [titleString rangeOfString:yahooString];
        if (range.location != NSNotFound)
        {
            //range.location is start of substring
            //range.length is length of substring
        }
        else
        {
             [titArray addObject:titleString];
        }
    }
    
    if([elementName isEqualToString:@"link"])
    {
         itemSelected=NO;
        if ([titArray count]>0)
        {
            [linkArray addObject:mutstrlink];
        }
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [tabView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
   
    [cell.newsHeadlineLabel setText:[NSString stringWithFormat:@"%@",[titArray objectAtIndex:indexPath.row]]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *strs = [[linkArray objectAtIndex:indexPath.row] componentsSeparatedByString: @"html"]; 

    NSString *urlAddress =[NSString stringWithFormat:@"%@html",[strs objectAtIndex:0]];
    
    NewsDetailViewController *detailViewController=[[NewsDetailViewController alloc]init];
    [detailViewController setUrlAddress:urlAddress];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

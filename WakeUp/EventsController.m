//
//  EventsController.m
//  WakeUp
//
//  Created by Tiyasi on 8/11/12.
//  Copyright (c) 2012 Tiyasi. All rights reserved.
//

#import "EventsController.h"
#import "ZeventsAPIManager.h"
#import "MyMBProgressHUD.h"
#import "EventDetailViewController.h"

@interface EventsController ()
{
    ZeventsAPIManager *api;
    NSMutableArray *events;
    NSMutableArray *eventDetails;
    NSMutableString *description;
    NSString *classElement;
    NSMutableArray *eventsArray;
    UITableView *tabView;
    NSDictionary *resultData;
}
@end

@implementation EventsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    tabView=[[UITableView alloc]initWithFrame:[self.view bounds]];
    [self.view addSubview:tabView];
    [tabView setDelegate:self];
    [tabView setDataSource:self];
    [tabView release];
    
    api = [[ZeventsAPIManager alloc] init];
  
    eventsArray=[[NSMutableArray alloc]init];
    events = [[NSMutableArray alloc] initWithCapacity:10];
    eventDetails = [[NSMutableArray alloc] init];
    
    [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:NO];
    api = [[ZeventsAPIManager alloc] init];
    [api fetchEvents:^(BOOL success, id result){
        if(success)
        {
            for(id each in [result objectForKey:@"popularevents"])
            {
                [events addObject:[[[each objectForKey:@"event"] objectForKey:@"id"] stringValue]];
                [eventsArray addObject:[[each objectForKey:@"event"]objectForKey:@"name"]];
            }
            
            //NSLog(@"\n\n\n\n\nresult=%@",result);
        }
        else
        {
            NSLog(@"some error.");
        }
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:NO];
        [tabView reloadData];
    }];
    
    [self setTitle:@"Events"];
}


-(void)fetchEventDetailsWithEventName:(NSString *)eventId
{
    
    [api fetchEventDetailsForEvent:eventId withCallback:^(BOOL success, id result)
    {
        resultData=result;
        //NSLog(@"\n\n\n\n\n\ndetails - %@", resultData);
        
        EventDetailViewController *detailViewController=[[EventDetailViewController alloc]initWithData:resultData];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [eventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController setNavigationBarHidden:NO];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    cell.textLabel.textColor =[UIColor blackColor];
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    cell.textLabel.text = [eventsArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self fetchEventDetailsWithEventName:[events objectAtIndex:indexPath.row]];
}
 


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

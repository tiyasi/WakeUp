//
//  EventDetailViewController.m
//  WakeUp
//
//  Created by Tiyasi on 27/11/12.
//  Copyright (c) 2012 Tiyasi. All rights reserved.
//

#import "EventDetailViewController.h"
#import "WebImageOperations.h"
#import "MyMBProgressHUD.h"

@interface EventDetailViewController ()
{
    NSDictionary *eventData;
}
@end

@implementation EventDetailViewController

-(id)initWithData:(NSDictionary *)data
{
    eventData=[[NSDictionary alloc]initWithDictionary:data];
    if(self=[super init])
    {
        [self.view setBackgroundColor:[UIColor underPageBackgroundColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewDesign];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)OnClick_btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDesign
{
    [self.navigationItem setTitle:[[eventData objectForKey:@"event"]objectForKey:@"name"]];
    self.navigationItem.hidesBackButton=YES;
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"Back"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(OnClick_btnBack:)];
    self.navigationItem.leftBarButtonItem = btnBack;
    [btnBack release];
    
    
    UIImageView *eventImgV=[[UIImageView alloc]init];
    [eventImgV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:eventImgV];
    [eventImgV release];
    [eventImgV setFrame:CGRectMake(50,0,100, 100)];
    
    [eventImgV setFrame:CGRectMake(self.view.frame.size.width/2-50,5,100, 100)];
    [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:NO];
    NSString *imageUrlString=[[[eventData objectForKey:@"event"]objectForKey:@"image"]objectForKey:@"profile"];
    
    [WebImageOperations processImageDataWithURLString:imageUrlString andBlock:^(NSData *imageData)
     {
         UIImage *image = [UIImage imageWithData:imageData];
         [eventImgV setFrame:CGRectMake(self.view.frame.size.width/2-image.size.width/2,5,
                                        image.size.width, image.size.height)];
         [eventImgV setImage:image];
         [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:NO];
     }];
    
    UILabel *venueHeadingLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,eventImgV.frame.origin.y+eventImgV.frame.size.height+40,50, 15)];
    [venueHeadingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0]];
    [venueHeadingLabel setTextColor:[UIColor blackColor]];
    [venueHeadingLabel setTextAlignment:UITextAlignmentLeft];
    [venueHeadingLabel setText:@"Venue"];
    [venueHeadingLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:venueHeadingLabel];
    [venueHeadingLabel release];
    
    NSString *streetAddress=[[[[[[eventData objectForKey:@"event"]objectForKey:@"shows"]objectAtIndex:0]
                               objectForKey:@"show"]objectForKey:@"venue"]objectForKey:@"venue_name"];
    UILabel *eventAddressLabel=[[UILabel alloc]initWithFrame:CGRectMake
                                (5,venueHeadingLabel.frame.origin.y+venueHeadingLabel.frame.size.height+2,
                                 self.view.frame.size.width-150, 40)];
    [eventAddressLabel setNumberOfLines:2];
    [eventAddressLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    [eventAddressLabel setText:[NSString stringWithFormat:@"%@  %@",streetAddress,[[eventData objectForKey:@"event"]objectForKey:@"city"]]];
    [eventAddressLabel setTextAlignment:UITextAlignmentLeft];
    [eventAddressLabel setTextColor:[UIColor blackColor]];
    [eventAddressLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:eventAddressLabel];
    [eventAddressLabel release];
    
    UILabel *timeHeadingLabel=[[UILabel alloc]initWithFrame:CGRectMake
                               (eventAddressLabel.frame.origin.x+eventAddressLabel.frame.size.width+20,
                                eventImgV.frame.origin.y+eventImgV.frame.size.height+40,
                                50, 15)];
    [timeHeadingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0]];
    [timeHeadingLabel setTextColor:[UIColor blackColor]];
    [timeHeadingLabel setTextAlignment:UITextAlignmentLeft];
    [timeHeadingLabel setText:@"Time"];
    [timeHeadingLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:timeHeadingLabel];
    [timeHeadingLabel release];
    
    NSString *startDate=[[[[[eventData objectForKey:@"event"]objectForKey:@"shows"]objectAtIndex:0]
                          objectForKey:@"show"]objectForKey:@"timing_long"];
    NSString *time=[[[[[eventData objectForKey:@"event"]objectForKey:@"shows"]objectAtIndex:0]
                     objectForKey:@"show"]objectForKey:@"time"];
    UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake
                        (timeHeadingLabel.frame.origin.x-10,
                         timeHeadingLabel.frame.origin.y+timeHeadingLabel.frame.size.height+2,
                         130, 40)];
    [timeLabel setNumberOfLines:3];
    [timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    [timeLabel setText:[NSString stringWithFormat:@"Date-%@   Time-%@",startDate, time]];
    [timeLabel setTextAlignment:UITextAlignmentLeft];
    [timeLabel setTextColor:[UIColor blackColor]];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:timeLabel];
    [timeLabel release];
    
    UILabel *phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake
                         (timeLabel.frame.origin.x,
                          timeLabel.frame.origin.y+timeLabel.frame.size.height,
                          130, 30)];
    [phoneLabel setNumberOfLines:2];
    [phoneLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    [phoneLabel setTextColor:[UIColor blackColor]];
    [phoneLabel setTextAlignment:UITextAlignmentLeft];
    [phoneLabel setText:[NSString stringWithFormat:@"Phone:%@",[[eventData objectForKey:@"event"]objectForKey:@"mobile_phone"]]];
    [phoneLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:phoneLabel];
    [phoneLabel release];
    
    UILabel *descriptionHeadingLabel=[[UILabel alloc]initWithFrame:CGRectMake
                                      (5,eventAddressLabel.frame.origin.y+eventAddressLabel.frame.size.height+20,
                                       100, 15)];
    [descriptionHeadingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0]];
    [descriptionHeadingLabel setTextColor:[UIColor blackColor]];
    [descriptionHeadingLabel setTextAlignment:UITextAlignmentLeft];
    [descriptionHeadingLabel setText:@"Description"];
    [descriptionHeadingLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:descriptionHeadingLabel];
    [descriptionHeadingLabel release];
    
    UITextView *descriptionTextView=[[UITextView alloc]initWithFrame:
                                     CGRectMake(5,descriptionHeadingLabel.frame.origin.y+descriptionHeadingLabel.bounds.size.height+10,
                                                self.view.frame.size.width-10,150)];
    [descriptionTextView setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    [descriptionTextView setText:[[eventData objectForKey:@"event"]objectForKey:@"description"]];
    [descriptionTextView setTextAlignment:UITextAlignmentLeft];
    [descriptionTextView setTextColor:[UIColor blackColor]];
    [descriptionTextView setEditable:NO];
    [descriptionTextView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:descriptionTextView];
    [descriptionTextView release];
}


@end

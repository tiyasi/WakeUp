//
//  TimeViewController.m
//  WakeUp
//
//  Created by Tiyasi on 8/11/12.
//  Copyright (c) 2012 Tiyasi. All rights reserved.
//

#import "TimeViewController.h"
#import "JDDateCountdownFlipView.h"
#import "WeatherView.h"
#import "SetAlarmController.h"
#import "UIView+Extension/UIView+Extension.h"
#import "ZeventsAPIManager.h"
#import "HUDLoader/MyMBProgressHUD.h"
#import "EventsController.h"

@interface TimeViewController ()
{
    NSMutableArray *events;
    NSMutableArray *eventDetails;
    BOOL filterAnimationON;
    UIScrollView *verticalScroll;
}
@end
#define WIDTH_OF_SLIDER 230

@implementation TimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Wake Up!";
    }
    
    
    return self;
}

-(void)sliderInStop
{
    filterAnimationON = FALSE;
}


-(void)bringNews
{
    //NS: here your tableView of news witll come
    NewsController *newsViewController=[[NewsController alloc]init];
    [self.navigationController pushViewController:newsViewController animated:YES];
}

-(void)bringEvents
{
    EventsController *eventsViewController=[[EventsController alloc]init];
    [self.navigationController pushViewController:eventsViewController animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *newsButton = [[UIBarButtonItem alloc]initWithTitle:@"News" style:UIBarButtonItemStylePlain target:self action:@selector(bringNews)];
    
    UIBarButtonItem *eventButton= [[UIBarButtonItem alloc] initWithTitle:@"Event" style:UIBarButtonItemStylePlain target:self action:@selector(bringEvents)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:newsButton, eventButton, nil];

    //NS: do whatever VIEW stuff you want to do in the method layoutSubviews --
    
    //NS: put the next alarm time here (which has been set by the user)
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: 60*60*1.75];
    JDDateCountdownFlipView *flipView = [[JDDateCountdownFlipView alloc] initWithTargetDate: date];
    [flipView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview: flipView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutSubviews];
}

-(void)setAlarm
{
    SetAlarmController *alarmController = [[SetAlarmController alloc] init];
    
    [alarmController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:alarmController animated:YES];
    [alarmController release];
}

- (void)layoutSubviews
{
    UIView* view = [[self.view subviews] objectAtIndex: 0];
    
    view.frame = CGRectMake(0, 0, self.view.frame.size.width-40, self.view.frame.size.height-40);
    view.center = CGPointMake(self.view.frame.size.width /2,
                              (self.view.frame.size.height/2)*0.9+200);
    
    UILabel *nextAlarm = [[UILabel alloc] initWithFrame:CGRectMake(20, (self.view.frame.size.height/2)*0.9+200-80, 150, 40)];
    [nextAlarm setText:@"Next Ring:"];
    [nextAlarm setTextAlignment:UITextAlignmentLeft];
    [nextAlarm setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:25]];
    [self.view addSubview:nextAlarm];
    [nextAlarm release];
    
    WeatherView *weatherView=[[WeatherView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self.view addSubview:weatherView];
    [weatherView release];
    
    UIButton *setAlarmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [setAlarmBtn setFrame:CGRectMake(320-100, 300, 90, 40)];
    [setAlarmBtn setBackgroundColor:[UIColor blackColor]];
    [setAlarmBtn setTitle:@"Set More" forState:UIControlStateNormal];
    [setAlarmBtn.titleLabel setFont:[UIFont fontWithName:@"AmericanTypewriter" size:15]];
    [setAlarmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [setAlarmBtn setBorderWidth:2.0 withColor:[UIColor blackColor] withCornerRadius:4.0];
    [setAlarmBtn addTarget:self action:@selector(setAlarm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setAlarmBtn];
 
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

//
//  SetAlarmController.m
//  WakeUp
//
//  Created by Tiyasi on 8/11/12.
//  Copyright (c) 2012 Tiyasi. All rights reserved.
//

#import "SetAlarmController.h"
#import <AVFoundation/AVFoundation.h>

@interface SetAlarmController ()
{
    UIDatePicker *datePicker;
    NSDate *datePickerTime;
    UILocalNotification *localNotification;
    UIButton *closeButton;
    NSInteger hourNow;
    NSInteger minuteNow;
    NSInteger hourDatePicker;
    NSInteger minuteDatePicker;
    NSCalendar *calendar;
    AVAudioPlayer *audioPlayer;
}

@end

@implementation SetAlarmController

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
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.8]];
    
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundColor:[UIColor greenColor]];
    [backButton setFrame:CGRectMake(5, 5, 54, 40)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    NSTimeZone *timeZone=[NSTimeZone localTimeZone];
    
    datePicker =[[UIDatePicker alloc]init];
    [datePicker setFrame:CGRectMake((320-250)/2, 100, 250, 50)];
    [datePicker setTimeZone:timeZone];
    [datePicker setMinimumDate:[NSDate date]];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(pickerDidStop:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    [datePicker release];
    
    NSLog(@"Current date=%@",[NSDate date]);
    NSLog(@"timezon=%@",timeZone);
}

-(void)pickerDidStop:(id)sender
{
    NSLog(@"picker stopped at date=%@",[datePicker date]);
    datePickerTime=[datePicker date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
    NSDateComponents *components2 = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[datePicker date]];
    hourNow = [components1 hour];
    minuteNow = [components1 minute];
    hourDatePicker = [components2 hour];
    minuteDatePicker = [components2 minute];
    
    NSLog(@"Hour now and minute now=%d and %d",hourNow,minuteNow);
    NSLog(@"Hour datePicker and minute DatePicker=%d and %d",hourDatePicker,minuteDatePicker);
    
    NSTimeInterval timeDifference=[datePickerTime timeIntervalSinceNow]/60;
    NSLog(@"timeDifference=%f",timeDifference);
    
}

-(void)backButtonMethod:(id)sender
{
    NSLog(@"Hello");
    [self dismissModalViewControllerAnimated:YES];
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

//
//  ZeventsAPIManager.h
//  EventAlgoTest
//
//  Created by Tiyasi on 7/5/12.
//  Copyright (c) 2012 Tiyasi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyMBProgressHUD.h"

typedef void(^EventzAPICallback)(BOOL success, id result);

@interface ZeventsAPIManager : NSObject
{
    EventzAPICallback callback;
    
    NSURLConnection *urlConnection;
    NSString *status;
    int statusCode;
    NSMutableData *respdata;
    NSDictionary *respDict;
    NSString *reuqestedURL;    
}

@property(nonatomic, retain) EventzAPICallback callback;

-(void)fetchEvents:(EventzAPICallback)_callback;
-(void)fetchEventDetailsForEvent:(NSString *)eventID withCallback:(EventzAPICallback)_callback;

@end

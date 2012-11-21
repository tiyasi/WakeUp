//
//  ZeventsAPIManager.m
//  EventAlgoTest
//
//  Created by Tiyasi on 7/5/12.
//  Copyright (c) 2012 Tiyasi. All rights reserved.
//

#import "ZeventsAPIManager.h"
#import "JSON.h"

#define GUARD_RELEASE(object) if(object!=nil){[object release]; object = nil;}
#define ZEVENTS_API_KEY @"DMKHTEQICDPIASQJRQXIFJNUBTDJYWVTYWEUEVDTEPOQJHSCPWFTBVYLMTYXUQUC"

#define ZOMATO_API_KEY @"4f93928d0ea9c4355356094f93928d0e"
#define ZOMATO_API_KEY_HEADER @"X-Zomato-API-Key"


@implementation ZeventsAPIManager

@synthesize callback;

-(void)fetchEventDetailsForEvent:(NSString *)eventID withCallback:(EventzAPICallback)_callback
{
    [self setCallback:[[_callback copy]autorelease]];
    
    //NSLog(@"fetching events for Zevents.");
    
    //NS: required API call here to the ZOMATO server12.9833° N, 77.5833° E
    NSURL *aUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.zomato.com/v1/event.json/%d", [eventID intValue]]];
//    NSURL *aUrl = [NSURL URLWithString: @"https://api.zomato.com/v1/search.json/near?lat=12.9833&lon=77.5833"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0];
    
    [request addValue:ZOMATO_API_KEY forHTTPHeaderField:ZOMATO_API_KEY_HEADER];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    
    urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [urlConnection start];
}

-(void)fetchEvents:(EventzAPICallback)_callback
{
    [self setCallback:[[_callback copy]autorelease]];
    //NSLog(@"fetching events for Zevents.");
    
    //NS: required API call here to the ZOMATO server
    
    NSURL *aUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.zomato.com/v1/events/popular.json?city_id=4"]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0];
    
    [request addValue:ZOMATO_API_KEY forHTTPHeaderField:ZOMATO_API_KEY_HEADER];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    
    urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [urlConnection start];
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{    
    statusCode = [((NSHTTPURLResponse *)response) statusCode];    
    respdata =[[NSMutableData alloc] init];    
    reuqestedURL = [[response URL] absoluteString];    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{    
    [respdata appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    NSDictionary *errorInfo;
    
    if(respdata)
    {
        NSString* Resp = [[[NSString alloc] initWithData:respdata encoding:NSUTF8StringEncoding]autorelease];        
        errorInfo = [Resp JSONValue];
    }
    else
    {
        errorInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
                                                        NSLocalizedString(@"Server returned status code %d",@""),
                                                        statusCode]
                                                forKey:NSLocalizedDescriptionKey];
    }    
    
    //NSError *statusError = [NSError errorWithDomain:@"HTTPStatus error" code:statusCode userInfo:errorInfo];
    
    GUARD_RELEASE(respdata);
    GUARD_RELEASE(urlConnection);    
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection 
{    
    NSString* Resp = [[[NSString alloc] initWithData:respdata encoding:NSUTF8StringEncoding]autorelease];
    
    if(([respdata length]>0)&&(([Resp length]>0)&&(![Resp isEqual:@"null"])&&(statusCode==200)) )
    {
        if(self.callback !=nil)
        {
            self.callback(YES, [Resp JSONValue]);
        }        
    }
    else
    {
        NSString *errorString = nil;
        if(statusCode == 401)
        {
            errorString = [NSString stringWithFormat:@"ErrorCode 401."];
            
        }
        else if(statusCode == 403)
        {
            errorString = [NSString stringWithFormat:@"ErrorCode 403."];
        }
        
        NSError *statusError = [NSError errorWithDomain:@"HTTPStatus error"
                                                   code:statusCode
                                               userInfo: [NSDictionary dictionaryWithObjectsAndKeys:
                                                          errorString ,@"status",
                                                          [NSString stringWithFormat:@"%i",statusCode],@"statusCode", 
                                                          nil]];
        
        if(self.callback!=nil) 
        {
            self.callback(NO, statusError);
        }
        
        GUARD_RELEASE(respdata);
        GUARD_RELEASE(urlConnection);    
    }
}

@end

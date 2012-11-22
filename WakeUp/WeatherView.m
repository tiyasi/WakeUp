//
//  WeatherView.m
//  YahooAPIsXML
//
//  Created by Tiyasi Acharya on 10/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        weatherArray=[[NSMutableArray alloc]init];
        values=[[[NSMutableArray alloc]init]autorelease];
        aDictionary=[[[NSMutableDictionary alloc]init]autorelease];
        
        // Construct the web service URL
//        NSURL *url2=[NSURL URLWithString:@"http://weather.yahooapis.com/forecastrss?w=2295420&u=c?yweather:location"];
//        NSURL *url2 = [NSURL URLWithString:@"http://weather.yahoo.com/india/karnataka/bangalore-2295420/"]; 
//        NSURL *url2 = [NSURL URLWithString:@"http://news.yahoo.com/rss"]; 
        
        
        
        NSURL *url2=[NSURL URLWithString:@"http://weather.yahooapis.com/forecastrss?w=2295420&u=c"];
        xmlParser2=[[NSXMLParser alloc]initWithContentsOfURL:url2];
        [xmlParser2 setDelegate:self];
        [xmlParser2 parse];
        
    }
    return self;
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{  
    if (attributeDict!=NULL) 
    {
        [values addObject:attributeDict];
        [aDictionary addEntriesFromDictionary:attributeDict];
    }

    
    classElement=[elementName retain];
    
    if ([classElement isEqualToString:@"title"])
    {
        title=[[NSMutableString alloc]init];
    }
    
    if ([classElement isEqualToString:@"description"])
    {
        description=[[NSMutableString alloc]init];
    }
    
    if ([classElement isEqualToString:@"lastBuildDate"])
    {
        todaysDate=[[NSMutableString alloc]init];
    }
    
    if ([classElement isEqualToString:@"ttl"])
    {
        wind=[[NSMutableString alloc]init];
    }
    if ([classElement isEqualToString:@"yweather:condition"])
    {
        weatherCondition=[[NSMutableString alloc]init];
    }
    if ([classElement isEqualToString:@"url"])
    {
        imageString=[[NSMutableString alloc]init];
    }
    
//    if([elementName isEqualToString:@"item"])
//    {
//        itemSelected =YES;
//        headingString=[[NSMutableString alloc]init];
////        mutstrlink=[[NSMutableString alloc]init];
//    }
    
//            classElement=elementName;
//            NSLog(@"elementName=%@",classElement);
//    NSLog(@"headingString=%@",headingString);
    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
       
    //These are the headlines
    
//    [weatherTitle appendString:string];
    
    [todaysDate appendString:string];
    [description appendString:string];
    [wind appendString:string];
    [weatherCondition appendString:string];
    [title appendString:string];
    [imageString appendString:string];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    
    if ([classElement isEqualToString:@"title"])
    {
        if (title!=nil)
        {
            if(title!=NULL)
        {
            [weatherArray addObject:title];
        }
        }
        
        [title release];
        title=nil;
    }
    
    if ([classElement isEqualToString:@"description"])
    {
        if (description!=nil)
        {
            if(description!=NULL)
            {
                [weatherArray addObject:description];
            }
        }
        
        [description release];
        description=nil;
    }
    
    if ([classElement isEqualToString:@"lastBuildDate"])
    {
        if (todaysDate!=nil)
        {
            if (todaysDate!=NULL)
        {
            [weatherArray addObject:todaysDate];
        }
        }
        [todaysDate release];
        todaysDate=nil;
    }
    
    if ([classElement isEqualToString:@"yweather:wind"])
    {
        if (wind!=nil)
        {
            if(wind!=NULL)
        {
            [weatherArray addObject:wind];
        }
        }
        [wind release];
        wind=nil;
    }
    
    if ([classElement isEqualToString:@"yweather:condition"])
    {
        if (weatherCondition!=nil)
        {
            if(weatherCondition!=NULL)
            {
                [weatherArray addObject:weatherCondition];
            }
        }
        [weatherCondition release];
        weatherCondition=nil;
    }
    
    if ([classElement isEqualToString:@"url"])
    {
        if (imageString!=nil)
        {
            if(imageString!=NULL)
            {
                [weatherArray addObject:imageString];
            }
        }
        [imageString release];
        imageString=nil;
    }

}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{

    [self letsLoadView];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
}

-(void)letsLoadView
{
    NSArray *descriptionArray=[[NSArray alloc]init];
    
    NSString *substring = nil;
    NSRange newlineRange = [[NSString stringWithFormat:@"%@",[weatherArray objectAtIndex:8]] rangeOfString:@"\n"];
    if(newlineRange.location != NSNotFound)
    {
        substring = [[NSString stringWithFormat:@"%@",[weatherArray objectAtIndex:8]] substringFromIndex:newlineRange.location];
    }
    descriptionArray=[substring componentsSeparatedByString:@"\""];

    NSURL *url5 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[descriptionArray objectAtIndex:1]]];
    UIImageView *descripImageView=[[UIImageView alloc]initWithFrame:CGRectMake(320/2-100-20, 35, 60, 40)];
    [descripImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url5]]];
    [self addSubview:descripImageView];
    [descripImageView release];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[weatherArray objectAtIndex:5]]];
    UIImageView *weatherImageView=[[UIImageView alloc]initWithFrame:CGRectMake(320/2-142/2, 10, 142, 23)];
    [weatherImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
    [self addSubview:weatherImageView];
    [weatherImageView release];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(320/2-100+60-5, 40, 320-(320/2-100+60), 30)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:UITextAlignmentLeft];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [titleLabel setText:[NSString stringWithFormat:@"%@",[[[[weatherArray objectAtIndex:0] componentsSeparatedByString:@"-"] objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
    [self addSubview:titleLabel];
    [titleLabel release];
    
    UILabel *todaysDateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 90, 320, 30)];
    [todaysDateLabel setBackgroundColor:[UIColor clearColor]];
    [todaysDateLabel setTextAlignment:UITextAlignmentCenter];
    [todaysDateLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [todaysDateLabel setText:[NSString stringWithFormat:@"%@",[weatherArray objectAtIndex:2]]];
    [self addSubview:todaysDateLabel];
    [todaysDateLabel release];
    
    UILabel *windLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                120, 320, 40)];
    [windLabel setBackgroundColor:[UIColor clearColor]];
    [windLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [windLabel setTextAlignment:UITextAlignmentCenter];
    [windLabel setText:[NSString stringWithFormat:@"Wind Chill - %@",[weatherArray objectAtIndex:3]]];
    [self addSubview:windLabel];
    [windLabel release];
    
    NSArray *arr=[[NSString stringWithFormat:@"%@",[values objectAtIndex:25]]componentsSeparatedByString:@";"];
    //NSLog(@"dictionary=%@",arr);
    
    NSRange newlineRange1 = [[NSString stringWithFormat:@"%@",[arr objectAtIndex:1]] rangeOfString:@"\""];
    if(newlineRange1.location != NSNotFound)
    {
        substring = [[NSString stringWithFormat:@"%@",[arr objectAtIndex:1]] substringFromIndex:newlineRange1.location];
    }
    NSLog(@"sub=%@",substring);
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:substring,nil];
    
    NSRange newlineRange2 = [[NSString stringWithFormat:@"%@",[arr objectAtIndex:3]] rangeOfString:@"\""];
    if(newlineRange2.location != NSNotFound)
    {
        substring = [[NSString stringWithFormat:@"%@",[arr objectAtIndex:3]] substringFromIndex:newlineRange1.location];
    }
    NSLog(@"sub=%@",substring);
    [array addObject:substring];
    
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(-80,10, 200, 80)];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    [tempLabel setNumberOfLines:3];
    [tempLabel setTextAlignment:UITextAlignmentCenter];
    [tempLabel setText:[NSString stringWithFormat:@"%@C",[aDictionary objectForKey:@"temp"]]];
    [self addSubview:tempLabel];
    [tempLabel release];
    
//    UILabel *sunLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,140, 120, 40)];
//    [sunLabel setBackgroundColor:[UIColor clearColor]];
//    [sunLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//    [sunLabel setNumberOfLines:2];
//    [sunLabel setTextAlignment:UITextAlignmentCenter];
//    [sunLabel setText:[NSString stringWithFormat:@"Sunrise - %@\nSunset - %@",[aDictionary objectForKey:@"sunrise"],
//                       [aDictionary objectForKey:@"sunset"]]];
//    [self addSubview:sunLabel];
//    [sunLabel release];
    
    UILabel *climateNowLabel=[[UILabel alloc]initWithFrame:CGRectMake(50,
                                                                      130, 200, 80)];
    [climateNowLabel setBackgroundColor:[UIColor clearColor]];
    [climateNowLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [climateNowLabel setNumberOfLines:3];
    [climateNowLabel setTextAlignment:UITextAlignmentCenter];
    [climateNowLabel setText:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]];
    [self addSubview:climateNowLabel];
    [climateNowLabel release];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

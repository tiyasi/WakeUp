//
//  WeatherView.h
//  YahooAPIsXML
//
//  Created by Tiyasi Acharya on 10/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView<NSXMLParserDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    NSXMLParser *xmlParser2;
    NSMutableString *weatherTitle;
    NSMutableString *headingString;
    NSMutableArray *weatherArray;
    NSString *classElement;
    BOOL itemSelected;
    NSMutableString *todaysDate;
    NSMutableString *description;
    NSMutableString *wind;
    NSMutableString *weatherCondition;
    NSMutableString *title;
    NSMutableString *imageString;
    NSMutableArray *values;
    NSMutableDictionary *aDictionary;
    
    
}

@end

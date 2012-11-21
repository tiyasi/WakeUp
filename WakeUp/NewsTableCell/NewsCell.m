//
//  NewsCell.m
//  WakeUp
//
//  Created by Tiyasi on 26/11/12.
//  Copyright (c) 2012 Tiyasi. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

@synthesize newsHeadlineLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        newsHeadlineLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 220,44)];
        [newsHeadlineLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
        [newsHeadlineLabel setTextColor:[UIColor blueColor]];
        [newsHeadlineLabel setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:newsHeadlineLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    // Configure the view for the selected state
    [super setSelected:selected animated:animated];
}

-(void)dealloc
{
    [newsHeadlineLabel release];
    newsHeadlineLabel=nil;
    [super dealloc];
    
}

@end

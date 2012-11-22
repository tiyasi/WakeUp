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
        newsHeadlineLabel=[[UILabel alloc]initWithFrame:CGRectMake(10.0, 0.0, self.frame.size.width-40.0, 44.0)];
        [newsHeadlineLabel setFont:[UIFont fontWithName:@"Helvetica" size:16.0]];
        [newsHeadlineLabel setTextColor:[UIColor blackColor]];
        [newsHeadlineLabel setBackgroundColor:[UIColor clearColor]];
        [newsHeadlineLabel setLineBreakMode:UILineBreakModeTailTruncation];
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

//
//  PWSCalendarDayCell.m
//  PWSCalendar
//
//  Created by Sylar on 3/14/14.
//  Copyright (c) 2014 PWS. All rights reserved.
//
////////////////////////////////////////////////////////////////////////
#import "PWSCalendarDayCell.h"
#import "PWSHelper.h"
////////////////////////////////////////////////////////////////////////
const NSString* PWSCalendarDayCellId = @"PWSCalendarDayCellId";
////////////////////////////////////////////////////////////////////////
@interface PWSCalendarDayCell()
{
    UILabel* m_date;
    UIImageView *imageView;
}
@property (nonatomic, strong) NSDate* p_date;
@end
////////////////////////////////////////////////////////////////////////
@implementation PWSCalendarDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self SetInitialValue];
    }
    return self;
}

- (void) SetInitialValue
{
    m_date = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH/7 - 4, SCREEN_WIDTH/7 - 4)];
    
//    [m_date setFrame:self.bounds];
    [m_date setText:@""];
    [m_date setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:m_date];
    
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        if ([PWSHelper CheckSameDay:self.p_date AnotherDate:[NSDate date]])
        {
            [m_date setTextColor:[UIColor whiteColor]];
        }
        else
        {
            [m_date setTextColor:[UIColor whiteColor]];
        }
        m_date.layer.cornerRadius = 10;
        m_date.layer.masksToBounds = YES;
        m_date.layer.borderWidth = 0.0;
        [m_date setBackgroundColor:kPWSDefaultColor];
    }
    else
    {
        if ([PWSHelper CheckSameDay:self.p_date AnotherDate:[NSDate date]])
        {
            [m_date setTextColor:[UIColor blackColor]];
            m_date.layer.cornerRadius = 10;
            m_date.layer.masksToBounds = YES;
            m_date.layer.borderWidth = 1;
            m_date.layer.borderColor = kPWSDefaultColor.CGColor;
            
        }
        else
        {
            [m_date setTextColor:[UIColor blackColor]];
            m_date.layer.cornerRadius = 10;
            m_date.layer.masksToBounds = YES;
            m_date.layer.borderWidth = 0;
            m_date.layer.borderColor = kPWSDefaultColor.CGColor;
        }
        

        [m_date setBackgroundColor:[UIColor clearColor]];

    }
}
-(void)setList:(NSMutableArray *)List {
    _List = List;
}
- (void) SetDate:(NSDate*)_date
{
    NSString* day = @"";
    self.p_date = _date;
    if (_date)
    {
        NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:_date];
        day = [NSString stringWithFormat:@"%@", @(dateComponents.day)];
    }
   
    if ([PWSHelper CheckSameDay:_date AnotherDate:[NSDate date]])
    {
        [m_date setTextColor:[UIColor blackColor]];
        m_date.layer.cornerRadius = 10;
        m_date.layer.masksToBounds = YES;
        m_date.layer.borderWidth = 1;
        m_date.layer.borderColor = kPWSDefaultColor.CGColor;
//        [self setSelected:YES];
    }
    else
    {
        [m_date setTextColor:[UIColor blackColor]];
        m_date.layer.cornerRadius = 0;
        m_date.layer.masksToBounds = NO;
        m_date.layer.borderWidth = 0;
        m_date.layer.borderColor = [[UIColor clearColor] CGColor];
       
    }
    
    [m_date setText:day];
   
    if (self.List.count > 0) {
        
        NSDateFormatter* ff = [[NSDateFormatter alloc] init];
        [ff setDateFormat:@"yyyy-MM-dd"];
        NSString* date = [ff stringFromDate:_date];
        for (NSDictionary *dic in self.List) {
            if ([[dic objectForKey:@"wdate"] isEqualToString:date]) {
                imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/7 - 16)/2, CGRectGetMaxY(m_date.frame) - 15, 16, 16)];
                imageView.image = [UIImage imageNamed:@"user_info_gold_gold"];
                imageView.hidden = NO;
                [self addSubview:imageView];
            }
        }
    }
    
    
}


@end

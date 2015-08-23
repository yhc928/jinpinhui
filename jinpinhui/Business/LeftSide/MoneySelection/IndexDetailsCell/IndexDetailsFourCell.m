//
//  IndexDetailsFourCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsFourCell.h"
#define table_width ((SCREEN_WIDTH-30)/3)

@implementation IndexDetailsFourCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (int i = 0; i < 3; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15+i*table_width, 0, table_width, 40)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FONT_28PX;
            label.numberOfLines = 2;
            label.tag = i+1;
            [self.contentView addSubview:label];
        }
    }
    
    return self;
}

- (void)setRowStr:(NSString *)rowStr
{
    _rowStr = rowStr;
    
    NSArray *rowArray = [_rowStr componentsSeparatedByString:@"|"];
    
    for (int i = 0; i < 3 && i < rowArray.count; i++) {
        UILabel *label = (UILabel *)[self.contentView viewWithTag:i+1];
        label.text = rowArray[i];
    }
}

@end

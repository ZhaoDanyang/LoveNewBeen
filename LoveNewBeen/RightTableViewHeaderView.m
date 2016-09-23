//
//  RightTableViewHeaderView.m
//  LoveNewBeen
//
//  Created by DY on 16/9/22.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "RightTableViewHeaderView.h"

@implementation RightTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:0.8];
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 20)];
        self.name.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.name];
    }
    return self;
}
@end

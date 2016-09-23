//
//  LeftCell.m
//  LoveNewBeen
//
//  Created by DY on 16/9/22.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "LeftCell.h"
#import "LNBModel.h"


@interface LeftCell()

@property (nonatomic,strong) UILabel *nameLb;

@end

@implementation LeftCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *ID = @"leftCell";
    
    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[LeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.nameLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 70, 30)];
        self.nameLb.textAlignment = NSTextAlignmentCenter;
        self.nameLb.font = [UIFont systemFontOfSize:15];
        self.nameLb.textColor = [UIColor blackColor];
        self.nameLb.highlightedTextColor = [UIColor redColor];
        [self.contentView addSubview:self.nameLb];
    }
    return self;
}

- (void)setModel:(LNBModel *)model{
    
    self.nameLb.text = model.name;
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.nameLb.highlighted = selected;

}


@end

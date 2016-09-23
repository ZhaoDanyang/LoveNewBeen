//
//  RightCell.m
//  LoveNewBeen
//
//  Created by DY on 16/9/22.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "RightCell.h"
#import "childModel.h"
#import "UIImageView+WebCache.h"
#import "ZDYTabBarVc.h"
#import "AddShopCarsAnimationTool.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface RightCell()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *addShopCarButton;

@end

@implementation RightCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *ID = @"RightCell";
    
    RightCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[RightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [self.contentView addSubview:self.imageV];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 100, 30)];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
        
        self.addShopCarButton = [[UIButton alloc]initWithFrame:CGRectMake(220, 45, 30, 30)];
        [self.addShopCarButton setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
        [self.addShopCarButton addTarget:self action:@selector(addShopCarMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addShopCarButton];
        
    }
    return self;
}

- (void)setCModel:(childModel *)cModel{
    
    _cModel = cModel;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:cModel.icon_url] placeholderImage:[UIImage imageNamed:@"default_pic"]];
    self.nameLabel.text = cModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",@(100)];

}

- (void) addShopCarMethod{
    
    CGRect rect = self.contentView.frame;
    
    rect.origin.y = rect.origin.y - self.contentView.frame.origin.y;
    
    CGRect imgRect = _imageV.frame;
    
    imgRect.origin.y = rect.origin.y + imgRect.origin.y;
    
    [[AddShopCarsAnimationTool shareTool] startAnimationWithView:_imageV withRect:imgRect withEndRectPoint:CGPointMake(ScreenWidth/4*2.5, ScreenHeight-49) withfinishBlock:^(BOOL finish) {
        
        ZDYTabBarVc *tabBarVc =(ZDYTabBarVc *)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        UIView *tabView = tabBarVc.tabBar.subviews[3];
        [AddShopCarsAnimationTool scaleAnimation:tabView];
    }];
}

@end

//
//  LeftCell.h
//  LoveNewBeen
//
//  Created by DY on 16/9/22.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LNBModel;

@interface LeftCell : UITableViewCell

@property(nonatomic,strong) LNBModel *model;

+ (instancetype) cellWithTableView: (UITableView *)tableView;

@end

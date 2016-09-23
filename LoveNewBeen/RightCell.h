//
//  RightCell.h
//  LoveNewBeen
//
//  Created by DY on 16/9/22.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class childModel;

@interface RightCell : UITableViewCell

@property (nonatomic,strong) childModel *cModel;

+ (instancetype) cellWithTableView: (UITableView *)tableView;

@end

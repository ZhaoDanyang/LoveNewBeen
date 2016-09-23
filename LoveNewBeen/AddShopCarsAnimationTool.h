//
//  AddShopCarsAnimationTool.h
//  LoveNewBeen
//
//  Created by DY on 16/9/22.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^finishAnimationBlock)(BOOL finish);

@interface AddShopCarsAnimationTool : NSObject

@property (nonatomic,strong) CALayer *layer;
@property (nonatomic,copy) finishAnimationBlock finishAnimationBlock;

+(instancetype)shareTool;
/**
 *  开始动画
 *
 *  @param view        添加动画的view
 *  @param rect        view 的绝对frame
 *  @param endRectPoint 下落的位置
 *  @param animationFinisnBlock 动画完成回调
 */

- (void) startAnimationWithView: (UIView *)view withRect :(CGRect)rect withEndRectPoint: (CGPoint)endRectPoint withfinishBlock :(finishAnimationBlock)finish;

/**
 *  摇晃动画
 *
 */
+(void)scaleAnimation:(UIView *)scaleView;


@end

//
//  AddShopCarsAnimationTool.m
//  LoveNewBeen
//
//  Created by DY on 16/9/22.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "AddShopCarsAnimationTool.h"
#import "AppDelegate.h"

@implementation AddShopCarsAnimationTool

+ (instancetype)shareTool{
    
    return [[AddShopCarsAnimationTool alloc]init];
}

- (void)startAnimationWithView:(UIView *)view withRect:(CGRect)rect withEndRectPoint:(CGPoint)endRectPoint withfinishBlock:(finishAnimationBlock)finish{
    
    //获取view图层的内容、位置
    _layer = [CALayer layer];
    _layer.contents = view.layer.contents;
    _layer.contentsGravity = kCAGravityResizeAspectFill;
    _layer.masksToBounds = YES;
    _layer.cornerRadius = rect.size.width*0.5;
    _layer.bounds = rect;
    
    //添加到窗口图层
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.window.layer addSublayer:_layer];
    //定义起始位置 80是右边tableView的起始点
    _layer.position = CGPointMake(80+rect.origin.x+view.frame.size.width*0.5, CGRectGetMidY(rect));
    
    //通过贝塞尔曲线画路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //定义控制点
    CGPoint controlPoint = CGPointMake(endRectPoint.x, _layer.position.y);
    [path moveToPoint:_layer.position];
    [path addQuadCurveToPoint:endRectPoint controlPoint:controlPoint];
    
    //关键帧动画
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = path.CGPath;
    
    //旋转动画
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:12];
    rotateAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    rotateAnimation.removedOnCompletion = YES;
    
    //缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:2.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation.removedOnCompletion = NO;
    
    //动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[positionAnimation,rotateAnimation,scaleAnimation];
    group.duration = 1.2f;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    [_layer addAnimation:group forKey:@"group"];
    if (finish) {
        _finishAnimationBlock = finish;
    }

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (anim == [_layer animationForKey:@"group"]) {
        [_layer removeFromSuperlayer];
        _layer = nil;
        if (_finishAnimationBlock) {
            _finishAnimationBlock(YES);
        }
    }
}

+ (void)scaleAnimation:(UIView *)scaleView{
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.5]; // 开始时的倍率
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
    scaleAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation.removedOnCompletion = YES;
    scaleAnimation.repeatCount = 2;
    scaleAnimation.duration = 0.2;
    [scaleView.layer addAnimation:scaleAnimation forKey:@"scale"];
    
}
@end

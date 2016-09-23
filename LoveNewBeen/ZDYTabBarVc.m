//
//  ZDYTabBarVc.m
//  LoveNewBeen
//
//  Created by DY on 16/9/21.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "ZDYTabBarVc.h"
#import "SuperMarketVc.h"
#import "ViewController.h"
@interface ZDYTabBarVc ()

@end

@implementation ZDYTabBarVc

+ (void)initialize{
    
    NSMutableDictionary * selAttrs= [NSMutableDictionary dictionary];
    selAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:27/255.0 green:192/255.0 blue:168/255.0 alpha:1.0];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:selAttrs forState:UIControlStateSelected];
    
    [item setTitleTextAttributes:selAttrs forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self  addChildVc:[[ViewController alloc] init] withTitle:@"首页" withImage:@"me_home_default" withSelectImage:@"me_home_working"];
    [self addChildVc:[[SuperMarketVc alloc]init] withTitle:@"超市" withImage:@"me_animefans_default" withSelectImage:@"me_animefans_working"];
    [self addChildVc:[[ViewController alloc] init] withTitle:@"购物车" withImage:@"me_cart_default" withSelectImage:@"me_cart_working"];
    [self addChildVc:[[ViewController alloc]init] withTitle:@"个人中心" withImage:@"me_mine_default" withSelectImage:@"me_mine_working"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addChildVc :(UIViewController *)vc withTitle :(NSString *)title withImage: (NSString *)imageNamed withSelectImage :(NSString *)selectImageNamed{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageNamed];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImageNamed];
    [self addChildViewController:vc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

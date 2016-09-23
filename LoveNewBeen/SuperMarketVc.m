//
//  SuperMarketVc.m
//  LoveNewBeen
//
//  Created by DY on 16/9/21.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "SuperMarketVc.h"
#import "LNBModel.h"
#import "childModel.h"
#import "NSObject+Model.h"
#import "LeftCell.h"
#import "RightCell.h"
#import <MJExtension.h>
#import "RightTableViewHeaderView.h"

#define viewH [UIScreen mainScreen].bounds.size.height
#define viewW [UIScreen mainScreen].bounds.size.width

@interface SuperMarketVc ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftTableView;

@property (nonatomic,strong) UITableView *rightTableView;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,assign) BOOL isScrollDown;

@property (nonatomic,strong) NSMutableArray *sectionData;
@property (nonatomic,strong) NSMutableArray *rowData;
@end

@implementation SuperMarketVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _selectIndex = 0;
    _isScrollDown = YES;
    
    [self loadData];
    [self setupLeftTableView];
    [self setupRightTableView];
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

}

- (void) loadData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *categories = dict[@"data"][@"categories"];
    
    
    for (NSDictionary *dict in categories) {
        
        LNBModel *model = [LNBModel mj_objectWithKeyValues:dict];
        
        [self.sectionData addObject:model];

        NSMutableArray *arr = [NSMutableArray array];

        for (NSDictionary *dict in model.subcategories) {
            childModel *cModel = [childModel mj_objectWithKeyValues:dict];
            
            [arr addObject:cModel];
        }
        [self.rowData addObject:arr];
    }
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    

}

- (NSMutableArray *)sectionData{
    if (_sectionData == nil) {
        _sectionData = [NSMutableArray array];
    }
    return _sectionData;
}

- (NSMutableArray *)rowData{
    if (_rowData == nil) {
        _rowData = [NSMutableArray array];
    }
    return _rowData;
}

- (void) setupLeftTableView{
    
    UITableView *leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 80, viewH-69)];
    
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    
    [self.view addSubview:leftTableView];
    
    _leftTableView = leftTableView;
    
}

- (void) setupRightTableView{
    
    UITableView *rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(80, 20, viewW-80, viewH-69)];
    
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    
    [self.view addSubview:rightTableView];
    
    _rightTableView = rightTableView;
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView) {
        return 1;
    }
    else{
        return self.sectionData.count;
        
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.leftTableView) {
        return self.sectionData.count;
    }
    else{
        LNBModel *model = self.sectionData[section];
        
        return model.subcategories.count;
        
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTableView) {
        LeftCell *cell = [LeftCell cellWithTableView:tableView];
        LNBModel *model = self.sectionData[indexPath.row];
        cell.model = model;
        return cell;
    }
    else{
        RightCell *cell = [RightCell cellWithTableView:tableView];
        
        cell.cModel = self.rowData[indexPath.section][indexPath.row];
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == _rightTableView) {
        RightTableViewHeaderView *headView = [[RightTableViewHeaderView alloc]init];
        LNBModel *model = self.sectionData[section];
        headView.name.text = model.name;
        return headView;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTableView) {
        return 40;
    }
    else{
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _rightTableView) {
        return 15;

    }
    return 0;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        _selectIndex = indexPath.row;
        
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    //是否向上滚动 并非点击leftTableView实现滚动
    if((tableView == _rightTableView) && _rightTableView.dragging && !_isScrollDown) {
        
        [self selectRowAtIndexPath:section];
    }
}

- (void) tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    //是否向下滚动 并非点击leftTableView实现滚动
    if((tableView == _rightTableView) && _rightTableView.dragging && _isScrollDown) {
        
        [self selectRowAtIndexPath:section+1];
    }
}

- (void) selectRowAtIndexPath: (NSInteger) index{
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UITableView *tableView = (UITableView *)scrollView;
    
    // static 修饰 lastOffsetY 可以确保 lastOffsetY值是实时更新的
    static CGFloat lastOffsetY = 0;
    
    if (tableView == _rightTableView) {
        
        // 判断 _rightTableView 是向上滚动还是向下滚动
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

@end

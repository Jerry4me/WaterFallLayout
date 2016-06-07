//
//  ViewController.m
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ViewController.h"
#import "JRShop.h"
#import "JRShopCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "JRWaterFallView.h"
#import "JRWaterFallLayout.h"

@interface ViewController () <UICollectionViewDataSource, JRWaterFallLayoutDelegate>

/** 瀑布流view */
@property (nonatomic, weak) JRWaterFallView *waterFallView;

/** shops */
@property (nonatomic, strong) NSMutableArray *shops;

@end

@implementation ViewController

static NSString *shopCellReuseID = @"shop";

- (NSMutableArray *)shops
{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化瀑布流view
    [self setupCollectionView];
    
}

- (void)setupCollectionView
{
    // 创建瀑布流view
    JRWaterFallView *waterFallView = [JRWaterFallView waterFallViewWithFrame:self.view.bounds layoutDelegate:self];
    // 设置数据源
    waterFallView.dataSource = self;
    waterFallView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:waterFallView];
    self.waterFallView = waterFallView;
    
    // 注册cell
    [self.waterFallView registerNib:[UINib nibWithNibName:NSStringFromClass([JRShopCell class]) bundle:nil] forCellWithReuseIdentifier:shopCellReuseID];
    
    
    
    
    // 为瀑布流控件添加下拉加载和上拉加载
    self.waterFallView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 模拟网络请求
            
            // 清空数据
            [self.shops removeAllObjects];
            
            NSArray *newShops = [JRShop mj_objectArrayWithFilename:@"shops.plist"];
            [self.shops addObjectsFromArray:newShops];
            
            // 刷新数据
            [self.waterFallView reloadData];
            
            [self.waterFallView.mj_header endRefreshing];
        });
    }];
    // 第一次进入则自动加载
    [self.waterFallView.mj_header beginRefreshing];
    
    
    self.waterFallView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 模拟网络请求
            
            NSArray *moreShops = [JRShop mj_objectArrayWithFilename:@"shops.plist"];
            [self.shops addObjectsFromArray:moreShops];
            
            // 刷新数据
            [self.waterFallView reloadData];
            
            [self.waterFallView.mj_footer endRefreshing];
        });
    }];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    JRShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopCellReuseID forIndexPath:indexPath];
    
    // 给cell传递模型
    cell.shop = self.shops[indexPath.item];
    
    // 返回cell
    return cell;
}

#pragma mark - <JRWaterFallLayoutDelegate>
/**
 *  返回每个item的高度
 */
- (CGFloat)waterFallLayout:(JRWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width
{
    JRShop *shop = self.shops[index];
    CGFloat shopHeight = [shop.h doubleValue];
    CGFloat shopWidth = [shop.w doubleValue];
    return shopHeight * width / shopWidth;
}

//- (CGFloat)columnMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout
//{
//    return 50;
//}

//- (NSUInteger)columnCountOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout
//{
//    return 4;
//}

//- (CGFloat)rowMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout
//{
//    return 50;
//}

//- (UIEdgeInsets)edgeInsetsOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout
//{
//    return UIEdgeInsetsMake(30, 40, 50, 70);
//}


@end

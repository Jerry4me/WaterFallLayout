//
//  ViewController.m
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ViewController.h"
#import "JRWaterFallLayout.h"
#import "JRShop.h"
#import "JRShopCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"

@interface ViewController () <UICollectionViewDataSource, JRWaterFallLayoutDelegate>

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

/** shops */
@property (nonatomic, strong) NSMutableArray *shops;

@end

@implementation ViewController

static NSString *reuseIdentifier = @"shop";

- (NSMutableArray *)shops
{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化collectionView
    [self setupCollectionView];
    
}

- (void)setupCollectionView
{
    // 创建瀑布流布局
    JRWaterFallLayout *layout = [[JRWaterFallLayout alloc] init];
    // 设置代理
    layout.delegate = self;
    
    // 创建collectionView并且设置frame和layout
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    // 设置collectionView的数据源
    collectionView.dataSource = self;
    // 设置背景色
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 注册collectionViewCell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JRShopCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 为collectionView添加下拉加载和上拉加载
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 清空数据
            [self.shops removeAllObjects];
            
            NSArray *newShops = [JRShop mj_objectArrayWithFilename:@"shops.plist"];
            [self.shops addObjectsFromArray:newShops];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            [self.collectionView.mj_header endRefreshing];
        });
    }];
    // 第一次进入则自动加载
    [self.collectionView.mj_header beginRefreshing];
    
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            NSArray *moreShops = [JRShop mj_objectArrayWithFilename:@"shops.plist"];
            [self.shops addObjectsFromArray:moreShops];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            [self.collectionView.mj_footer endRefreshing];
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
    JRShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 给cell传递模型
    cell.shop = self.shops[indexPath.item];
    
    // 返回cell
    return cell;
}

#pragma mark - <JRWaterFallLayoutDelegate>
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

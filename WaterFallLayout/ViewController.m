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
#import "MJExtension.h"
#import "JRWaterFallView.h"

@interface ViewController () <UICollectionViewDataSource>

/** collectionView */
@property (nonatomic, weak) JRWaterFallView *waterFallView;

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
    JRWaterFallView *waterFallView = [[JRWaterFallView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:waterFallView];
    self.waterFallView = waterFallView;
    
    
    // 为collectionView添加下拉加载和上拉加载
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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



@end

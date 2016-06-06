//
//  ViewController.m
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ViewController.h"
#import "JRWaterFallLayout.h"

@interface ViewController () <UICollectionViewDataSource>

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController

static NSString *reuseIdentifier = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化collectionView
    [self setupCollectionView];
    
}

- (void)setupCollectionView
{
    // 创建瀑布流布局
    JRWaterFallLayout *layout = [[JRWaterFallLayout alloc] init];
    
    // 创建collectionView并且设置frame和layout
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    // 设置collectionView的数据源
    collectionView.dataSource = self;
    // 设置背景色
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 注册collectionViewCell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 设置cell的属性
    
    
    // 返回cell
    return cell;
}

@end

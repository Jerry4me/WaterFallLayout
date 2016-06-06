//
//  JRWaterFallLayout.m
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JRWaterFallLayout.h"


static const CGFloat JRDefaultColumnCount = 3; // 列数
static const CGFloat JRDefaultRowMargin = 10; // 行间距
static const CGFloat JRDefaultColumnMargin = 10; // 列间距
static const UIEdgeInsets JRDefaultEdgeInsets = {10, 10, 10, 10}; // edgeInsets

@interface JRWaterFallLayout()

/** cell的布局属性数组 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

/** 每列的高度数组 */
@property (nonatomic, strong) NSMutableArray *columnHeights;

/** 最大Y值 */
@property (nonatomic, assign) CGFloat maxY;

@end

@implementation JRWaterFallLayout

#pragma mark - 懒加载

- (NSMutableArray *)columnHeights
{
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

#pragma mark - layout方法

/**
 *  准备布局
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 初始化列高度
    for (int i = 0; i < JRDefaultColumnCount; i++) {
        [self.columnHeights addObject:@(JRDefaultEdgeInsets.top)];
    }
    
    // 计算item的attrs
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [self.attrsArray addObject:attrs];
    }
    
    // 计算最大的Y值
    self.maxY = 0;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull heightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([heightNumber doubleValue] > self.maxY) {
            self.maxY = [heightNumber doubleValue];
        }
    }];
    
}


/**
 *  返回rect范围内的item的布局数组, (这个方法会频繁调用)
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}


/**
 *  返回indexPath位置的item布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 开始计算item的x, y, width, height
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    CGFloat width = (collectionViewWidth - JRDefaultEdgeInsets.left - JRDefaultEdgeInsets.right - (JRDefaultColumnCount - 1) * JRDefaultColumnMargin) / JRDefaultColumnCount;
    
    // 计算当前item应该摆放在第几列(计算哪一列高度最短)
    __block NSUInteger minColumn = 0; // 默认是第0列
    __block CGFloat minHeight = MAXFLOAT;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull heightNumber, NSUInteger idx, BOOL * _Nonnull stop) { // 遍历找出最小高度的列
        
        CGFloat height = [heightNumber doubleValue];
        
        if (minHeight > height) {
            minHeight = height;
            minColumn = idx;
        }
    }];
    
    
    CGFloat x = JRDefaultEdgeInsets.left + minColumn * (JRDefaultColumnMargin + width);
    CGFloat y = minHeight + JRDefaultRowMargin;
    
    
    CGFloat height = 50 + arc4random_uniform(100);
    
    attrs.frame = CGRectMake(x, y, width, height);
    
    // 更新数组中的最短列的高度
    self.columnHeights[minColumn] = @(y + height);
    
    return attrs;
}

/**
 *  返回collectionView的contentSize
 */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.maxY + JRDefaultEdgeInsets.bottom);
}

#pragma mark - 私有方法

@end

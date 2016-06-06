//
//  JRWaterFallLayout.m
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JRWaterFallLayout.h"

@implementation JRWaterFallLayout

/**
 *  准备布局
 */
- (void)prepareLayout
{
    [super prepareLayout];
}


/**
 *  返回rect范围内的item的布局
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return nil;
}


/**
 *  返回indexPath位置的item布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

/**
 *  返回collectionView的contentSize
 */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, 1000);
}

@end

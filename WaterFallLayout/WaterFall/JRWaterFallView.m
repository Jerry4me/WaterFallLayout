//
//  JRWaterFallView.m
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JRWaterFallView.h"
#import "MJRefresh.h"
#import "JRWaterFallLayout.h"

@interface JRWaterFallView() <JRWaterFallLayoutDelegate>

@end

@implementation JRWaterFallView

+ (instancetype)waterFallViewWithFrame:(CGRect)frame cellClass:(Class)cellClass
{
    return [[self alloc] initWithFrame:frame collectionViewLayout:[[JRWaterFallLayout alloc] init]];
}

+ (instancetype)waterFallViewWithFrame:(CGRect)frame modelNibName:(NSString *)modalNibName
{
    
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        // 设置layout的代理
        (JRWaterFallLayout *)layout.delegate = self;
        
        // 创建collectionView并且设置frame和layout
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];

    return self;
}


#pragma mark - <JRWaterFallLayoutDelegate>
//- (CGFloat)waterFallLayout:(JRWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width
//{
//    JRShop *shop = self.shops[index];
//    CGFloat shopHeight = [shop.h doubleValue];
//    CGFloat shopWidth = [shop.w doubleValue];
//    return shopHeight * width / shopWidth;
//}

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

//
//  JRWaterFallLayout.h
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRWaterFallLayout;

@protocol JRWaterFallLayoutDelegate <NSObject>

@required
- (CGFloat)waterFallLayout:(JRWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width;

@optional
- (NSUInteger)columnCountOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout;
- (CGFloat)rowMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout;
- (CGFloat)columnMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout;
- (UIEdgeInsets)edgeInsetsOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout;

@end

@interface JRWaterFallLayout : UICollectionViewLayout

/** 代理 */
@property (nonatomic, weak) id<JRWaterFallLayoutDelegate> delegate;

@end

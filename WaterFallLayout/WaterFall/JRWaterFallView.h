//
//  JRWaterFallView.h
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRWaterFallView : UICollectionView

/**
 *  创建并返回waterFallView
 *
 *  @param modelClass cell的类
 *
 */
+ (instancetype)waterFallViewWithFrame:(CGRect)frame cellClass:(Class)cellClass;

/**
 *  创建并返回waterFallView
 *
 *  @param modelClass cell的Nib字符串
 *
 */
+ (instancetype)waterFallViewWithFrame:(CGRect)frame modelNibName:(NSString *)modalNibName;

@end

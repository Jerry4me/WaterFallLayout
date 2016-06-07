//
//  JRWaterFallView.h
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JRWaterFallLayoutDelegate;

@interface JRWaterFallView : UICollectionView

/**
 *  创建一个瀑布流view
 *
 *  @param frame    瀑布流view的frame
 *  @param delegate 瀑布流布局的代理(可通过代理设置一些参数, 必须传)
 */
+ (nullable instancetype)waterFallViewWithFrame:(CGRect)frame layoutDelegate:(nonnull id<JRWaterFallLayoutDelegate>)layoutDelegate;


/** 瀑布流布局代理 */
@property (nonatomic, weak, readonly) id<JRWaterFallLayoutDelegate> layoutDelegate;

@end

//
//  JRWaterFallView.m
//  WaterFallLayout
//
//  Created by sky on 16/6/6.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JRWaterFallView.h"
#import "JRWaterFallLayout.h"

@interface JRWaterFallView()

/** 瀑布流布局代理(方便内部修改) */
@property (nonatomic, weak, readwrite) id<JRWaterFallLayoutDelegate> layoutDelegate;

@end

@implementation JRWaterFallView

+ (nullable instancetype)waterFallViewWithFrame:(CGRect)frame layoutDelegate:(nonnull id<JRWaterFallLayoutDelegate>)layoutDelegate
{
    JRWaterFallLayout *layout = [[JRWaterFallLayout alloc] init];
    JRWaterFallView *waterFallView = [[JRWaterFallView alloc] initWithFrame:frame collectionViewLayout:layout];
    // 设置瀑布流布局的代理
    layout.delegate = layoutDelegate;
    waterFallView.layoutDelegate = layoutDelegate;
    
    return waterFallView;
}
@end

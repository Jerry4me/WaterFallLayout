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

@end

@implementation JRWaterFallView

+ (instancetype)waterFallViewWithFrame:(CGRect)frame delegate:(id<JRWaterFallLayoutDelegate>)delegate
{
    // 创建瀑布流布局
    JRWaterFallLayout *layout = [[JRWaterFallLayout alloc] init];
    layout.delegate = delegate;
    
    JRWaterFallView *waterFallView = [[self alloc] initWithFrame:frame collectionViewLayout:layout];
    
    return waterFallView;
}

@end

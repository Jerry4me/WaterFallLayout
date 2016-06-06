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


+ (instancetype)waterFallViewWithFrame:(CGRect)frame delegate:(id<JRWaterFallLayoutDelegate>)delegate;


@end

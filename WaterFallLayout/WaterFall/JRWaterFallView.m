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

/** 重用标识 */
//@property (nonatomic, copy) NSString *reuseID;

@end

@implementation JRWaterFallView


+ (instancetype)waterFallViewWithFrame:(CGRect)frame delegate:(nonnull id<JRWaterFallLayoutDelegate>)delegate
{
    // 创建瀑布流布局
    JRWaterFallLayout *layout = [[JRWaterFallLayout alloc] init];
    layout.delegate = delegate;
    
    JRWaterFallView *waterFallView = [[self alloc] initWithFrame:frame collectionViewLayout:layout];
    
    return waterFallView;
}

//- (void)jr_registerClass:(Class)Class forCellWithReuseIdentifier:(NSString *)identifier
//{
//    self.reuseID = identifier;
//    [self registerClass:Class forCellWithReuseIdentifier:identifier];
//}
//
//- (void)jr_registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier
//{
//    self.reuseID = identifier;
//    [self registerNib:nib forCellWithReuseIdentifier:identifier];
//}

@end

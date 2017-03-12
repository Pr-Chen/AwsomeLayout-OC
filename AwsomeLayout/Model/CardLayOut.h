//
//  SFCardLayOut.h
//  SFCardLayOut
//
//  Created by Chen on 16/1/7.
//  Copyright © 2016年 陈凯. All rights reserved.
//
//  仿nice卡片滑动布局

#import <UIKit/UIKit.h>

@interface CardLayOut : UICollectionViewLayout

//cell间距
@property (nonatomic, assign) CGFloat spacing;

//cell的尺寸
@property (nonatomic, assign) CGSize itemSize;

//缩放率
@property (nonatomic, assign) CGFloat scale;

//边距
@property (nonatomic, assign) UIEdgeInsets edgeInset;

//滚动方向
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@end

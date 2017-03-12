//
//  AdsorptionLayout.h
//  AwsomeLayout
//
//  Created by Mr.Chen on 2017/3/12.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsorptionLayout : UICollectionViewLayout

//可见的cell尺寸
@property (nonatomic, assign) CGSize visibleSize;

//cell的尺寸
@property (nonatomic, assign) CGSize itemSize;

//边距
@property (nonatomic, assign) UIEdgeInsets edgeInset;

//悬浮边
@property (nonatomic, assign) UIRectEdge adsorptionEdge;

//滚动方向
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@end

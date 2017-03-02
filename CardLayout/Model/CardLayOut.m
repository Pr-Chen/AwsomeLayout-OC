//
//  SFCardLayOut.m
//  SFCardLayOut
//
//  Created by Chen on 16/1/7.
//  Copyright © 2016年 陈凯. All rights reserved.
//

#import "CardLayOut.h"

@interface CardLayOut ()

@property (strong, nonatomic) NSMutableArray *rectAttributes;

@end

@implementation CardLayOut

- (instancetype)init {
    if (self = [super init]) {
        [self defaultSetup];
    }
    return self;
}

- (void)defaultSetup {
    self.spacing = 20.0;
    self.itemSize = CGSizeMake(280, 400);
    self.edgeInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.scale = 1.0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat width = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? count*(self.itemSize.width+self.spacing)-self.spacing+self.edgeInset.left+self.edgeInset.right : self.collectionView.bounds.size.width;
    CGFloat height = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? self.collectionView.bounds.size.height : count*(self.itemSize.height+self.spacing)-self.spacing+self.edgeInset.top+self.edgeInset.bottom;
    return CGSizeMake(width, height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size = self.itemSize;
    
    CGFloat x = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? self.edgeInset.left + indexPath.item*(self.spacing+self.itemSize.width) : 0.5*(self.collectionView.bounds.size.width - self.itemSize.width);
    CGFloat y = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? 0.5*(self.collectionView.bounds.size.height - self.itemSize.height) : self.edgeInset.top + indexPath.item*(self.spacing+self.itemSize.height);
    attribute.frame = CGRectMake(x, y, attribute.size.width, attribute.size.height);
    
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [self attributesInRect:rect];
    
    if (self.scale==1) {
        return attributes;
    }
    //找到屏幕中间的位置
    CGFloat center = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? self.collectionView.contentOffset.x + 0.5*self.collectionView.bounds.size.width : self.collectionView.contentOffset.y + 0.5*self.collectionView.bounds.size.height;
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        //计算每一个cell离屏幕中间的距离
        CGFloat offset = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? ABS(attribute.center.x - center) : ABS(attribute.center.y - center);
        CGFloat space = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? self.itemSize.width+self.spacing : self.itemSize.height+self.spacing;
        if (offset<space) {
            CGFloat scale = 1+(1-offset/space)*(self.scale-1);
            attribute.transform = CGAffineTransformMakeScale(scale, scale);
            attribute.zIndex = 1;
        }
    }
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect oldRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *attributes = [self layoutAttributesForElementsInRect:oldRect];
    
    CGFloat minOffset = MAXFLOAT;
    CGFloat center = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? proposedContentOffset.x + 0.5*self.collectionView.bounds.size.width : proposedContentOffset.y + 0.5*self.collectionView.bounds.size.height;
    
    for (UICollectionViewLayoutAttributes* attribute in attributes) {
        CGFloat offset = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? attribute.center.x - center : attribute.center.y - center;
        if (ABS(offset) < ABS(minOffset)) {
            minOffset = offset;
        }
    }
    CGFloat newX = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? proposedContentOffset.x + minOffset : proposedContentOffset.x;
    CGFloat newY = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? proposedContentOffset.y : proposedContentOffset.y + minOffset;
    
    return CGPointMake(newX, newY);
}

- (NSArray *)attributesInRect:(CGRect)rect {
    
    NSInteger preIndex = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? (rect.origin.x-self.edgeInset.left)/(self.itemSize.width+self.spacing) : (rect.origin.y-self.edgeInset.top)/(self.itemSize.height+self.spacing);
    preIndex = preIndex<0 ? 0 : preIndex;
    
    NSInteger latIndex = self.scrollDirection==UICollectionViewScrollDirectionHorizontal ? (CGRectGetMaxX(rect)-self.edgeInset.left)/(self.itemSize.width+self.spacing) : (CGRectGetMaxY(rect)-self.edgeInset.top)/(self.itemSize.height+self.spacing);
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    latIndex = latIndex>=itemCount ? itemCount-1 : latIndex;
    
    [self.rectAttributes removeAllObjects];
    for (NSInteger i=preIndex; i<=latIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [self.rectAttributes addObject:attribute];
        }
    }
    return self.rectAttributes;
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    [self invalidateLayout];
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    [self invalidateLayout];
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset {
    _edgeInset = edgeInset;
    [self invalidateLayout];
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    [self invalidateLayout];
}

- (NSMutableArray *)rectAttributes {
    
    if (!_rectAttributes) {
        _rectAttributes = [NSMutableArray array];
    }
    return _rectAttributes;
}

@end

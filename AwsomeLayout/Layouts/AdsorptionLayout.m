//
//  AdsorptionLayout.m
//  AwsomeLayout
//
//  Created by Mr.Chen on 2017/3/12.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import "AdsorptionLayout.h"

@interface AdsorptionLayout ()

@property (strong, nonatomic) NSMutableArray *rectAttributes;

@end

@implementation AdsorptionLayout

- (instancetype)init {
    
    if (self = [super init]) {
        [self defaultSetup];
    }
    return self;
}

- (void)defaultSetup {
    
    self.visibleSize = CGSizeMake(0, 100);
    self.itemSize = CGSizeMake(345, 500);
    self.edgeInset = UIEdgeInsetsMake(64, 15, 15, 15);
    self.adsorptionEdge = UIRectEdgeTop;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat width = self.collectionView.bounds.size.width;
    CGFloat height = (count-1)*self.visibleSize.height+self.itemSize.height+self.edgeInset.top+self.edgeInset.bottom;
    return CGSizeMake(width, height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size = self.itemSize;
    
    CGFloat x = 0.5*(self.collectionView.bounds.size.width - self.itemSize.width);
    CGFloat y = self.edgeInset.top + indexPath.item*self.visibleSize.height;
    attribute.frame = CGRectMake(x, y, attribute.size.width, attribute.size.height);
    attribute.zIndex = indexPath.item;
    
    NSInteger preIndex = (self.collectionView.contentOffset.y-self.edgeInset.top)/self.visibleSize.height;
    preIndex = MAX(0, preIndex);
    if (attribute.frame.origin.y <= self.collectionView.contentOffset.y+self.edgeInset.top) {
        CGRect frame = attribute.frame;
        frame.origin.y = self.collectionView.contentOffset.y+self.edgeInset.top;
        attribute.frame = frame;
    }
    
    
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *attributes = [self attributesInRect:rect];
    return attributes;
}

- (NSArray *)attributesInRect:(CGRect)rect {
    
    NSInteger preIndex = (self.collectionView.contentOffset.y-self.edgeInset.top)/self.visibleSize.height;
    preIndex = MAX(0, preIndex);
    
    NSInteger latIndex = (self.collectionView.contentOffset.y+self.collectionView.bounds.size.height-self.edgeInset.top)/self.visibleSize.height;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    latIndex = MIN(itemCount-1, latIndex);
    
    [self.rectAttributes removeAllObjects];
    for (NSInteger i=preIndex; i<=latIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.rectAttributes addObject:attribute];
    }
    return self.rectAttributes;
}

- (NSMutableArray *)rectAttributes {
    
    if (!_rectAttributes) {
        _rectAttributes = [NSMutableArray array];
    }
    return _rectAttributes;
}

@end

## 卡片布局，支持水平、垂直滚动。
![](https://ww3.sinaimg.cn/large/006tNbRwly1fd8xu377fng305k09vdo5.gif)
![](https://ww2.sinaimg.cn/large/006tNbRwly1fd8xu51jf4g305k09vq9x.gif)
![](https://ww4.sinaimg.cn/large/006tNbRwly1fd8xug0iejg305k09vdu7.gif)
![](https://ww4.sinaimg.cn/large/006tNbRwly1fd8xuimwh4g305k09vn64.gif)

## 用法简单
```objective-c
CardLayOut *layout = [CardLayOut new];
self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
```

## 可以设置的属性
```objective-c
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
```

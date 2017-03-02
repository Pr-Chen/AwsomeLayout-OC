## 卡片布局，支持水平、垂直滚动。
![](https://ww3.sinaimg.cn/large/006tNbRwly1fd8uxqdcmkg305k09vam0.gif)
![](https://ww2.sinaimg.cn/large/006tNbRwly1fd8v36k4x7g305k09vaob.gif)
![](https://ww4.sinaimg.cn/large/006tNbRwly1fd8v39760ng305k09vnpd.gif)
![](https://ww1.sinaimg.cn/large/006tNbRwly1fd8v3d0ax0g305k09v48q.gif)

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

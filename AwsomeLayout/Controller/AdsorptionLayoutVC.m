//
//  AdsorptionLayoutVC.m
//  AwsomeLayout
//
//  Created by Mr.Chen on 2017/3/13.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import "AdsorptionLayoutVC.h"
#import "AdsorptionLayout.h"
#import "UIColor+Chameleon.h"

@interface AdsorptionLayoutVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *colors;

@end

@implementation AdsorptionLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = [self getRandomColors];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    AdsorptionLayout *layout = [AdsorptionLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    cell.backgroundColor = self.colors[indexPath.item];
    cell.layer.cornerRadius = 5;
    if (![cell viewWithTag:100]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 150, 50)];
        label.text = @"测试文字";
        [cell addSubview:label];
    }
    return cell;
}

- (NSArray *)getRandomColors {
    NSMutableArray *colors = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        UIColor *color = [UIColor randomFlatColor];
        [colors addObject:color];
    }
    return colors;
}


@end

//
//  XJWaterflowLayout.m
//  XJWaterflowLayout
//
//  Created by 邢进 on 2017/3/28.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "XJWaterflowLayout.h"

@interface XJWaterflowLayout();

//先有看下api吧:
//UICollectionViewLayoutAttributes用来管理布置相关属性

//管理UICollectionViewLayoutAttributes对象,每一个对象用来管理布置相关属性
@property (nonatomic, strong)NSMutableArray *attrsArray;
//存放每一列的高度,即Y的最大值
@property (nonatomic, strong)NSMutableDictionary *maxYDict;
@end

@implementation XJWaterflowLayout

//布局之前准备,就像api翻译的一样:给您的布局对象一个机会来准备即将到来的布局操作。☺☺☺☺☺☺☺☺
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 1.清空最大的Y值,并给一个初始值
    for (int i = 0; i<self.columnsCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d", i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    // 2.计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        
        //获取cell的布局属性:self.layoutAttributesForItemAtIndexPath 是本类的一个属性 通过对应的indexPath我们可以拿到对应的item的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

//必须实现的方法1
//设置collectionView的ContentSize
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    //x返回什么都行
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}

//必须实现的方法3
//返回视图的布局信息对象
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //假设最短的那一列的第0列
    __block NSString *minColumn = @"0";
    //找出最短的那一列,y最小
    //就是将后进来的插入到最短的那一列 所以要获取这个x坐标我们就需要找出这个最小的y坐标才能确定
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    //计算每个图片的尺寸. 屏幕宽-边距=宽, delegate提供高度
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount - 1) * self.columnMargin)/self.columnsCount;
    CGFloat height = [self.delegate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    //也可以根据indexPatch拿到image,在这里直接算宽,不使用delegate,涉及到model的处理
    //CGFloat height=image.size.height *(width/image.size.width)
    // 计算位置
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.rowMargin;
    // 更新这一列的最大Y值
    self.maxYDict[minColumn] = @(y + height);
    //创建属性管理对象
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;
}

//必须实现的方法2
//在里将我们存储起来的item布局属性交给cell
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}
//是否需要改变布局,默认no
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
//默认初始化间距,2列
- (instancetype)init {
    if (self = [super init]) {
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
        self.columnsCount = 2;
    }
    return self;
}

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [@[] mutableCopy];
    }
    return _attrsArray;
}
- (NSMutableDictionary *)maxYDict {
    if (!_maxYDict) {
        _maxYDict = [NSMutableDictionary new];
    }
    return _maxYDict;
}




@end

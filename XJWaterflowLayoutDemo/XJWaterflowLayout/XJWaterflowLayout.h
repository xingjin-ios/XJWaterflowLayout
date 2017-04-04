//
//  XJWaterflowLayout.h
//  XJWaterflowLayout
//
//  Created by 邢进 on 2017/3/28.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJWaterflowLayout;

@protocol XJWaterflowLayoutDele <NSObject>

//高度由delegate返回,这里不做图片计算,也可以不需要,.m中有详细介绍☺☺☺☺

- (CGFloat)waterflowLayout:(XJWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface XJWaterflowLayout : UICollectionViewLayout
//section间距
@property (nonatomic, assign)UIEdgeInsets sectionInset;
//列间距
@property (nonatomic, assign) CGFloat columnMargin;
//行间距
@property (nonatomic, assign) CGFloat rowMargin;
//多少列
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak)id<XJWaterflowLayoutDele> delegate;

@end

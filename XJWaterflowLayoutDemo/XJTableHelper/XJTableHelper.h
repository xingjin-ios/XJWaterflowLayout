//
//  XJTableHelper.h
//  XJBaseProject
//
//  Created by 邢进 on 2017/3/15.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//实现对tableView/collectionView datasource/delegate的封装
//dataSource
typedef void(^CellConfigureBlock)(id cell, id model, NSIndexPath *indexPath);
//可选用
typedef CGFloat(^CellHeightBlock)(NSIndexPath *indexPath, id model);
typedef void(^CellDidSelectBlock)(NSIndexPath *indexPath, id model);

@interface XJTableHelper : NSObject<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSString *identifier;
@property (nonatomic, copy)CellConfigureBlock cellConfigureBlock;
@property (nonatomic, copy)CellHeightBlock cellHeightBlock;
@property (nonatomic, copy)CellDidSelectBlock cellDidSelectBlock;
@property (nonatomic, strong)NSMutableArray *dataArray;//数据源使用

//dataSource
- (id)initWithidentifier:(NSString *)identifier cellConfigureBlock:(CellConfigureBlock)aBlock;
//dataSouce+delegate
- (id)initWithidentifier:(NSString *)identifier cellConfigureBlock:(CellConfigureBlock)aBlock cellHeightBlock:(CellHeightBlock)heightBlock cellDidSelectBlock:(CellDidSelectBlock)selectBlock;

//授权
- (void)handleView:(UITableView *)view delegate:(BOOL)delegate;

//设定数据源
- (void)addModels:(NSArray *)models;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;



@end

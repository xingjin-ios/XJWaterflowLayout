//
//  XJTableHelper.m
//  XJBaseProject
//
//  Created by 邢进 on 2017/3/15.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "XJTableHelper.h"

@interface XJTableHelper (){
    
}

@end

@implementation XJTableHelper

- (id)initWithidentifier:(NSString *)identifier cellConfigureBlock:(CellConfigureBlock)aBlock {
    if (self = [super init]) {
        _identifier = identifier;
        _cellConfigureBlock = [aBlock copy];
    }
    return self;
}

- (id)initWithidentifier:(NSString *)identifier cellConfigureBlock:(CellConfigureBlock)aBlock cellHeightBlock:(CellHeightBlock)heightBlock cellDidSelectBlock:(CellDidSelectBlock)selectBlock {
    if (self = [super init]) {
        _identifier = identifier;
        _cellConfigureBlock = [aBlock copy];
        _cellHeightBlock = [heightBlock copy];
        _cellDidSelectBlock = [selectBlock copy];
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return _dataArray.count > indexPath.row ? _dataArray[indexPath.row] : nil;
}

- (void)addModels:(NSArray *)models {
    if(!models) return;
    [self.dataArray addObjectsFromArray:models];
}

- (void)handleView:(UITableView *)view delegate:(BOOL)delegate; {
    view.dataSource = self;
    if (delegate)
    view.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray == nil ? 0 : _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    if (_cellConfigureBlock) {
        _cellConfigureBlock(cell, model, indexPath);
    }
    //也可不通过vc直接赋值cell
//    if ([cell respondsToSelector:@selector(configureCellWithModel:)]) {
//        [cell performSelector:@selector(configureCellWithModel:) withObject:model];
//    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self modelsAtIndexPath:indexPath] ;
    return self.cellHeightBlock(indexPath,model) ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id model = [self modelsAtIndexPath:indexPath] ;
    self.cellDidSelectBlock(indexPath,model) ;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray == nil ? 0: _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    
    if(_cellConfigureBlock) {
        _cellConfigureBlock(cell, model, indexPath);
    }
//    if ([cell respondsToSelector:@selector(configureCellWithModel:)]) {
//        [cell performSelector:@selector(configureCellWithModel:) withObject:model];
//    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelsAtIndexPath:indexPath];
    _cellHeightBlock(indexPath, model);
}

@end

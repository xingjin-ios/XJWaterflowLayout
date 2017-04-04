//
//  ViewController.m
//  XJWaterflowLayoutDemo
//
//  Created by 邢进 on 2017/4/4.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "ViewController.h"
#import "cellModel.h"
#import "MyCollectionViewCell.h"
#import "XJTableHelper.h"
#import "XJWaterflowLayout.h"

@interface ViewController ()<XJWaterflowLayoutDele>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong)XJTableHelper *tableHelper;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XJWaterflowLayout *flowLayout = [XJWaterflowLayout new];
    flowLayout.columnsCount = 2;//列数
    flowLayout.delegate = self;//返回高度代理,可以不要哦😯😯
    
    _myCollectionView.collectionViewLayout = flowLayout;
    _tableHelper = [[XJTableHelper alloc] initWithidentifier:@"MyCollectionViewCell" cellConfigureBlock:^(id cell, id model, NSIndexPath *indexPath) {
        [cell configureCellWithModel:model indexPatch:indexPath];
    }];
    _myCollectionView.dataSource = _tableHelper;
    [_tableHelper addModels:self.dataArray];
    [_myCollectionView reloadData];
    
}
#pragma mark - XJWaterflowLayoutDele
//delegate返回相应图片高
- (CGFloat)waterflowLayout:(XJWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    cellModel *photo = self.dataArray[indexPath.item];
    return photo.hh / photo.ww * width;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
        for (int i = 0; i < 15; i++) {
            cellModel *model = [cellModel createCellmodel];
            [self.dataArray addObject:model];
        }
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

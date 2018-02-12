//
//  Demo_52_CATiledLayer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/11.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_52_CATiledLayer.h"

@interface Demo_52_CATiledLayer ()<CALayerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *imagePaths;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation Demo_52_CATiledLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initAppearance];
}

#pragma mark - initDataSource
- (void)initDataSource {
    
    self.imagePaths = [NSMutableArray array];
    for (NSInteger i = 1; i < 5; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"vacation_%ld",i];
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        [self.imagePaths addObject:path];
    }
    
}

#pragma mark - initAppearance
- (void)initAppearance {
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imagePaths.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    CATiledLayer *tiledLayer = ((CATiledLayer *)[cell.contentView.layer.sublayers lastObject]);
    if (!tiledLayer) {
        tiledLayer = [CATiledLayer layer];
        tiledLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
        tiledLayer.contentsScale = [UIScreen mainScreen].scale;
        tiledLayer.tileSize = CGSizeMake(cell.bounds.size.width * [UIScreen mainScreen].scale, cell.bounds.size.height * [UIScreen mainScreen].scale);
        tiledLayer.delegate = self;
        [tiledLayer setValue:@(indexPath.item) forKey:@"index"];
        [cell.contentView.layer addSublayer:tiledLayer];
    }
    
    //tag the layer with the correct index and reload
    tiledLayer.contents = nil;
    [tiledLayer setValue:@(indexPath.item) forKey:@"index"];
    [tiledLayer setNeedsDisplay];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250.0;
}

#pragma mark - CALayerDelegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //get image index
    NSInteger index = [[layer valueForKey:@"index"] integerValue];
    NSString *imagePath = self.imagePaths[index];
    UIImage *titleImage = [UIImage imageWithContentsOfFile:imagePath];
    
    //计算图片rect
    CGFloat aspectRatio = titleImage.size.height / titleImage.size.width;
    CGRect imageRect = CGRectZero;
    imageRect.size.width = layer.bounds.size.width;
    imageRect.size.height = layer.bounds.size.height * aspectRatio;
    imageRect.origin.y = (layer.bounds.size.height - imageRect.size.height) / 2;
    
    //绘制
    UIGraphicsPushContext(ctx);
//    [titleImage drawInRect:imageRect];//按实际图片绘制
    [titleImage drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)];//按cell的大小绘制，铺满整个cell
    UIGraphicsPopContext();
}

/*
 说明：
 CATiledLayer的tileSize属性单位是像素，而不是点，所以为了保证瓦片和表格尺寸一致，需要乘以屏幕比例因子。
 
 在-drawLayer:inContext:方法中，我们需要知道图层属于哪一个indexPath以加载正确的图片。这里我们利用了CALayer的KVC来存储和检索任意的值，将图层和索引打标签
 
 */

#pragma mark - lazyLoading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,600) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end

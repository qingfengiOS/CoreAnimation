//
//  Demo_52_CATiledLayer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/11.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_52_CATiledLayer.h"

@interface Demo_52_CATiledLayer ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CALayerDelegate>

@property (nonatomic, strong) NSMutableArray *imagePaths;
@property (nonatomic, strong) UICollectionView *collectionView;

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
    
    [self.view addSubview:self.collectionView];
}


#pragma mark - CollectionViewDelegate/dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagePaths.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    /*
     CATiledLayer可以用来异步加载和显示大型图片，而不阻塞用户输入。但是我们同样可以使用CATiledLayer在UICollectionView中为每个表格创建分离的CATiledLayer实例加载传动器图片，每个表格仅使用一个图层。
    
     care:
     这样使用CATiledLayer有几个潜在的弊端：
     
     1、CATiledLayer的队列和缓存算法没有暴露出来，所以我们只能祈祷它能匹配我们的需求
     
     2、CATiledLayer需要我们每次重绘图片到CGContext中，即使它已经解压缩，而且和我们单元格尺寸一样（因此可以直接用作图层内容，而不需要重绘）
     */
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //add tiledLayer
    
    CATiledLayer *tiledLayer = ((CATiledLayer *)[cell.contentView.layer.sublayers lastObject]);
    if (!tiledLayer) {
        tiledLayer = [CATiledLayer layer];
        tiledLayer.frame = cell.bounds;
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
    [titleImage drawInRect:imageRect];//按实际图片绘制
//    [titleImage drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)];//按cell的大小绘制，铺满整个cell
    UIGraphicsPopContext();
}

/*
 说明：
 CATiledLayer的tileSize属性单位是像素，而不是点，所以为了保证瓦片和表格尺寸一致，需要乘以屏幕比例因子。
 
 在-drawLayer:inContext:方法中，我们需要知道图层属于哪一个indexPath以加载正确的图片。这里我们利用了CALayer的KVC来存储和检索任意的值，将图层和索引打标签
 
 */

#pragma mark - lazyLoading
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 250)  collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end

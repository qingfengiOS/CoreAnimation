//
//  Demo_51_imageIO.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/11.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_51_imageIO.h"

@interface Demo_51_imageIO ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *imagePaths;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation Demo_51_imageIO

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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    const NSInteger imageTag = 99;
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:imageTag];
    if (!imageView) {
        imageView = [[UIImageView alloc]initWithFrame:cell.contentView.frame];
        imageView.tag = imageTag;
        [cell.contentView addSubview:imageView];
    }
    cell.tag = indexPath.item;
    //方法一：直接加载图片
//    NSString *imagePath = self.imagePaths[indexPath.item];
//    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    /*
     问题：
     当传送器滚动的时候，图片也在实时加载，于是（预期中的）卡动就发生了。时间分析工具显示了很多时间都消耗在了UIImage的+imageWithContentsOfFile:方法中了。很明显，图片加载造成了瓶颈
     */
    
    
    /*
     方案：
     这里提升性能唯一的方式就是在另一个线程中加载图片。这并不能够降低实际的加载时间（可能情况会更糟，因为系统可能要消耗CPU时间来处理加载的图片数据），但是主线程能够有时间做一些别的事情，比如响应用户输入，以及滑动动画。
     
         为了在后台线程加载图片，我们可以使用GCD或者NSOperationQueue创建自定义线程，或者使用CATiledLayer
     */
    
    //方法二：使用GCD异步加载图片
//    imageView.image = nil;
//    //开启后台线程异步加载
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//       //异步加载图片
//        NSInteger index = indexPath.item;
//        NSString *imagePath = self.imagePaths[index];
//        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//
//        //回到主线程，显示图片
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (index == indexPath.item) {//加载下标符合当前展示的下标，图片才显示
//                imageView.image = image;
//            }
//        });
//    });
    
    //方法三：整张图片绘制到CGContext,强制图片解压显示
    /*
     最后一种方式就是使用UIKit加载图片，但是立刻会知道CGContext中去。图片必须要在绘制之前解压，所以就强制了解压的及时性。这样的好处在于绘制图片可以再后台线程（例如加载本身）执行，而不会阻塞UI。
     */
    CGRect imageViewRect = imageView.bounds;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSInteger index = indexPath.item;
        NSString *imagePath = self.imagePaths[index];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        //使用CGContext重绘
        UIGraphicsBeginImageContextWithOptions(imageViewRect.size, YES, 0);
        [image drawInRect:imageViewRect];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        //回到主线程，显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            if (index == cell.tag) {//加载下标符合当前展示的下标，图片才显示
                imageView.image = image;
            }
        });
        
    });
    
    return cell;
}

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

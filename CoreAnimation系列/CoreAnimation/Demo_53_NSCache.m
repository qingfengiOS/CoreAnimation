//
//  Demo_53_NSCache.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/12.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_53_NSCache.h"

@interface Demo_53_NSCache ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *imagePaths;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation Demo_53_NSCache

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
    //add image view
    UIImageView *imageView = [cell.contentView.subviews lastObject];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imageView];
    }
    //set or load image for this index
    UIImage *image = [self loadImageAtIndex:indexPath.item];
    imageView.image = image;
    //preload image for previous and next index
    if (indexPath.item < [self.imagePaths count] - 1) {
        [self loadImageAtIndex:indexPath.item + 1];
    }
    if (indexPath.item > 0) {
        [self loadImageAtIndex:indexPath.item - 1];
    }
    return cell;
}

/**
 通过index异步加载图片

 @param index 下标
 @return 图片
 */
- (UIImage *)loadImageAtIndex:(NSUInteger)index {
    //创建cache
    static NSCache *cache = nil;
    if (!cache) {
        cache = [[NSCache alloc]init];
    }
    UIImage *image = [cache objectForKey:@(index)];//取缓存
    if (image) {
        return [image isKindOfClass:[NSNull class]] ? nil : image;
    }

    //set placeholder to avoid reloading image multiple times”
    [cache setObject:[NSNull null] forKey:@(index)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        //load image
        NSString *imagePath = self.imagePaths[index];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];

        UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIScreen mainScreen].bounds.size.width, 250), YES, 0);
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //回到主线程，设置图片
        dispatch_async(dispatch_get_main_queue(), ^{
            [cache setObject:image forKey:@(index)];//存缓存
            //显示图片
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            UIImageView *imageView = [cell.contentView.subviews lastObject];
            imageView.image = image;
        });
    });
    return nil;
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

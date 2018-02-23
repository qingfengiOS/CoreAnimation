//
//  Demo_55_ReduceLayer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/23.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_55_ReduceLayer.h"

#define WIDTH 10
#define HEIGHT 10
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500

@interface Demo_55_ReduceLayer ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation Demo_55_ReduceLayer

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     在对图层做任何优化之前，你需要确定你不是在创建一些不可见的图层，图层在以下几种情况下回事不可见的：
     
     1、图层在屏幕边界之外，或是在父图层边界之外。
     2、完全在一个不透明图层之后。
     3、完全透明
     */
    [self initAppearance];
}

#pragma mark - initAppearance
- (void)initAppearance {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1) * SPACING, (HEIGHT - 1) * SPACING);
    //设置M34向量（视距）
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;
    
    //创建立方体Layer
    for (int z = DEPTH - 1; z >= 0; z--) {
        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) {
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x * SPACING, y * SPACING);
                layer.zPosition = -z * SPACING;
                
                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
                [self.scrollView.layer addSublayer:layer];
            }
        }
    }
    NSLog(@"displayed: %i", DEPTH*HEIGHT*WIDTH);
    
    
}

@end

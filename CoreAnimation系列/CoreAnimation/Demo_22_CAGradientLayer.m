//
//  Demo_22_CAGradientLayer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/18.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_22_CAGradientLayer.h"

@interface Demo_22_CAGradientLayer ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *containerView2;

@end

@implementation Demo_22_CAGradientLayer

- (void)viewDidLoad {
    [super viewDidLoad];

    //基础渐变
    /*
     CAGradientLayer是用来生成两种或更多颜色平滑渐变的。用Core Graphics复制一个CAGradientLayer并将内容绘制到一个普通图层的寄宿图也是有可能的，但是CAGradientLayer的真正好处在于绘制使用了硬件加速。
    */

    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(20, 64, 200, 200)];
    [self.view addSubview:self.containerView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.frame;
    [self.containerView.layer addSublayer:gradientLayer];
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor];
    
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    
    //多重渐变 在渐变上使用locations
    
    /*
     如果你愿意，colors属性可以包含很多颜色，所以创建一个彩虹一样的多重渐变也是很简单的。默认情况下，这些颜色在空间上均匀地被渲染，但是我们可以用locations属性来调整空间。locations属性是一个浮点数值的数组（以NSNumber包装）。这些浮点数定义了colors属性中每个不同颜色的位置，同样的，也是以单位坐标系进行标定。0.0代表着渐变的开始，1.0代表着结束。
     
     locations数组并不是强制要求的，但是如果你给它赋值了就一定要确保locations的数组大小和colors数组大小一定要相同，否则你将会得到一个空白的渐变.
     */
    self.containerView2 = [[UIView alloc]initWithFrame:CGRectMake(20, 300, 200, 200)];
    [self.view addSubview:self.containerView2];
    
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = self.containerView.frame;
    [self.containerView2.layer addSublayer:gradientLayer2];
    
    //set gradient colors
    gradientLayer2.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor];
    
    //set locations
    gradientLayer2.locations = @[@0.2, @0.5, @0.8];//设置渐变范围
    
    //set gradient start and end points
    gradientLayer2.startPoint = CGPointMake(1, 0);
    gradientLayer2.endPoint = CGPointMake(0, 1);
}


@end

//
//  Demo_30_CAKeyfraneAnimationWithUIBezierPath.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/22.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_30_CAKeyfraneAnimationWithUIBezierPath.h"

@interface Demo_30_CAKeyfraneAnimationWithUIBezierPath (){
    UIBezierPath *path;
    CALayer *shipLayer;
}
@property (nonatomic, strong) UIView *containerView;
@end

@implementation Demo_30_CAKeyfraneAnimationWithUIBezierPath

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     提供一个数组的值就可以按照颜色变化做动画，但一般来说用数组来描述动画运动并不直观。CAKeyframeAnimation有另一种方式去指定动画，就是使用CGPath。path属性可以用一种直观的方式，使用Core Graphics函数定义运动序列来绘制动画。
     
     我们来用一个宇宙飞船沿着一个简单曲线的实例演示一下。为了创建路径，我们需要使用一个三次贝塞尔曲线，它是一种使用开始点，结束点和另外两个控制点来定义形状的曲线，可以通过使用一个基于C的Core Graphics绘图指令来创建，不过用UIKit提供的UIBezierPath类会更简单。
     */
    self.containerView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.containerView];
    
    //careate Path
    path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(50, 150)];
    [path addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 25)  controlPoint2:CGPointMake(225, 300)];
    
    //draw th path use a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = path.CGPath;
    pathLayer.fillColor = [UIColor whiteColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    //add the ship image layer
    shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(50, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"air"].CGImage;
    shipLayer.contentsGravity = kCAGravityCenter;
    [self.containerView.layer addSublayer:shipLayer];
    
    [self rePlay];
    
    UIButton *rePlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rePlayBtn.frame = CGRectMake(0, 0, 100, 50);
    rePlayBtn.center = self.containerView.center;
    [rePlayBtn addTarget:self action:@selector(rePlay) forControlEvents:UIControlEventTouchUpInside];
    [rePlayBtn setTitle:@"再来一次" forState:UIControlStateNormal];
    [rePlayBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.containerView addSubview:rePlayBtn];
}

- (void)rePlay {
    
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 5.0f;
    animation.path = path.CGPath;//CAKeyframeAnimation有另一种方式去指定动画，就是使用CGPath

    /*
     你会发现飞船的动画有些不太真实，这是因为当它运动的时候永远指向右边，而不是指向曲线切线的方向。你可以调整它的affineTransform来对运动方向做动画，但很可能和其它的动画冲突。
     
     幸运的是，苹果预见到了这点，并且给CAKeyFrameAnimation添加了一个rotationMode的属性。设置它为常量kCAAnimationRotateAuto，图层将会根据曲线的切线自动旋转。
     */
    animation.rotationMode = kCAAnimationRotateAuto;
    [shipLayer addAnimation:animation forKey:nil];
}

@end

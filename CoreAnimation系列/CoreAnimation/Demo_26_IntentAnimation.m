//
//  Demo_26_IntentAnimation.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/19.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_26_IntentAnimation.h"

@interface Demo_26_IntentAnimation ()
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong)  CALayer *colorLayer;

@end

@implementation Demo_26_IntentAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:self.containerView];
    
    /*
     移除layer 测试

     */
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = self.containerView.bounds;
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.containerView.layer addSublayer:self.colorLayer];
    
    self.containerView.layer.backgroundColor = [UIColor blueColor].CGColor;
    
    UIButton *changBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changBtn.frame = CGRectMake(100, 300, 200, 50);
    [changBtn setTitle:@"changeColor" forState:UIControlStateNormal];
    [changBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changBtn];
}

- (void)change {
    
    //begin a new transaction
    [CATransaction begin];
    
    /*
     CATransacition有个方法叫做+setDisableActions:，可以用来对所有属性打开或者关闭隐式动画
     */
//    [CATransaction setDisableActions:YES];
    
    //set the animation duration to 1 second
    [CATransaction setAnimationDuration:1.0];
    
    /*
     移除layer 测试
     */
    //add the spin animation on completion
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    
    
    /*
     移除layer 测试
     发现：当按下按钮，图层颜色瞬间切换到新的值，而不是之前平滑过渡的动画。
     Core Animation通常对CALayer的所有属性（可动画的属性）做动画，但是UIView把它关联的图层的这个特性关闭了。
     */
//     self.containerView.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    //commit the transaction
    [CATransaction commit];
    
}

@end

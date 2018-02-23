//
//  Demo_54_DrawRectByCAShapeLayer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/23.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_54_DrawRectByCAShapeLayer.h"

@interface Demo_54_DrawRectByCAShapeLayer ()
@property (nonatomic, strong) UIView *containerView;
@end

@implementation Demo_54_DrawRectByCAShapeLayer

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     cornerRadius和maskToBounds独立作用的时候都不会有太大的性能问题，但是当他俩结合在一起，就触发了屏幕外渲染。有时候你想显示圆角并沿着图层裁切子图层的时候，你可能会发现你并不需要沿着圆角裁切，这个情况下用CAShapeLayer就可以避免这个问题了。
     */
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(50, 64, 300, 300)];
    [self.view addSubview:self.containerView];
    
    CAShapeLayer *blueLayer = [CAShapeLayer layer];
    blueLayer.frame = CGRectMake(20, 50, 80, 50);
    blueLayer.fillColor = [UIColor blueColor].CGColor;
    blueLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 80, 50) cornerRadius:10].CGPath;
    [self.containerView.layer addSublayer:blueLayer];
 
    /*
     图片拉伸
     另一个创建圆角矩形的方法就是用一个圆形内容图片并结合第二章『寄宿图』提到的contensCenter属性去创建一个可伸缩图片（见清单15.2）.理论上来说，这个应该比用CAShapeLayer要快，因为一个可拉伸图片只需要18个三角形（一个图片是由一个3*3网格渲染而成），然而，许多都需要渲染成一个顺滑的曲线。在实际应用上，二者并没有太大的区别。
     */
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50, 150, 80, 60);
    layer.contentsCenter = CGRectMake(0.5, 0.5, 0.0, 0.0);
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.contents = (__bridge id)[UIImage imageNamed:@"1"].CGImage;
    [self.containerView.layer addSublayer:layer];
}




@end

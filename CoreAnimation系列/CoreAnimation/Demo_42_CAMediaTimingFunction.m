//
//  Demo_41_CAMediaTimingFunction.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/23.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_42_CAMediaTimingFunction.h"

@interface Demo_42_CAMediaTimingFunction ()
@property (nonatomic, strong)  UIView *layerView;
@end

@implementation Demo_42_CAMediaTimingFunction

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     CAMediaTimingFunction使用了一个叫做三次贝塞尔曲线的函数，它只可以产出指定缓冲函数的子集（我们之前在第八章中创建CAKeyframeAnimation路径的时候提到过三次贝塞尔曲线）。
     
     你或许会回想起，一个三次贝塞尔曲线通过四个点来定义，第一个和最后一个点代表了曲线的起点和终点，剩下中间两个点叫做控制点，因为它们控制了曲线的形状，贝塞尔曲线的控制点其实是位于曲线之外的点，也就是说曲线并不一定要穿过它们。你可以把它们想象成吸引经过它们曲线的磁铁。
 
     CAMediaTimingFunction有一个叫做-getControlPointAtIndex:values:的方法，可以用来检索曲线的点，这个方法的设计的确有点奇怪（或许也就只有苹果能回答为什么不简单返回一个CGPoint），但是使用它我们可以找到标准缓冲函数的点，然后用UIBezierPath和CAShapeLayer来把它画出来。
     
     */
    
    self.layerView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:self.layerView];
    
    //create timing function
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
    //get control points
    CGPoint controlPoint1, controlPoint2;
    [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
    [function getControlPointAtIndex:2 values:(float *)&controlPoint2];
    
    //create curve
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1)
            controlPoint1:controlPoint1
            controlPoint2:controlPoint2];
    
    //scale the path up to a reasonable size for display
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [self.layerView.layer addSublayer:shapeLayer];
    
    //flip geometry so that 0,0 is in the bottom-left
    self.layerView.layer.geometryFlipped = YES;
    

}



@end

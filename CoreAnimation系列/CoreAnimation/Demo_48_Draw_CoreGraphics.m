//
//  Demo_48_Draw_CoreGraphics.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/9.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_48_Draw_CoreGraphics.h"
#import "Demo_48_Draw_CoreGraphics_View.h"

@interface Demo_48_Draw_CoreGraphics ()

@end

@implementation Demo_48_Draw_CoreGraphics

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Demo_48_Draw_CoreGraphics_View *view = [[Demo_48_Draw_CoreGraphics_View alloc]initWithFrame:self.view.frame];
    [self.view addSubview:view];
    
    
    /*
     这样实现的问题在于，我们画得越多，程序就会越慢。因为每次移动手指的时候都会重绘整个贝塞尔路径（UIBezierPath），随着路径越来越复杂，每次重绘的工作就会增加，直接导致了帧数的下降。看来我们需要一个更好的方法了。
     
         Core Animation为这些图形类型的绘制提供了专门的类，并给他们提供硬件支持（第六章『专有图层』有详细提到）。CAShapeLayer可以绘制多边形，直线和曲线。CATextLayer可以绘制文本。CAGradientLayer用来绘制渐变。这些总体上都比Core Graphics更快，同时他们也避免了创造一个寄宿图。(见Demo_49_Draw_CAShapeLayer)
     
     */
}

@end

//
//  ViewController.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/15.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "ViewController.h"
#import "Demo_01_Layer.h"
#import "Demo_02_Contents.h"
#import "Demo_03_ContentsRect.h"
#import "Demo_04_ContentsCenter.h"
#import "Demo_05_DrawLayer.h"
#import "Demo_06_AnchorPoint.h"
#import "Demo_07_ZPosition.h"
#import "Demo_08_ContainsPoint.h"
#import "Demo_09_ShadowPath.h"
#import "Demo_10_Mask.h"
#import "Demo_11_ShouldRasterize.h"
#import "Demo_12_AffineTransform.h"
#import "Demo_13_Mix_AffineTransform.h"//多次变换
#import "Demo_14_CATransform3D.h"//3D变换
#import "Demo_15_SublayerTransform.h"//“视距”相同
#import "Demo_16_Mutable_Rotation.h"//内外部旋转叠加效果
#import "Demo_17_Mutable_Rotation_3D.h"//图层扁平化
#import "Demo_18_Cube.h"//创建一个立方体
#import "Demo_19_CAShapeLayer.h"
#import "Demo_20_CATextLayer.h"
#import "Demo_21_CATransformLayer.h"
#import "Demo_22_CAGradientLayer.h"//平滑过渡颜色
#import "Demo_23_CAReplicatorLayer.h"//复制多个图形
#import "Demo_24_CAEmitterLayer.h"//粒子效果
#import "Demo_25_CAEAGLLayer.h"//使用OpenGL+GLKit高效绘图
#import "Demo_26_IntentAnimation.h"//隐式动画
#import "Demo_27_IntentAnimation_Principle.h"//隐式动画实现原理+自定义Layer行为
#import "Demo_28_PresentationLayer.h"//用presentationLayer图层来判断当前图层位置
#import "Demo_29_CAKeyframeAnimation.h"//关键帧动画
#import "Demo_30_CAKeyfraneAnimationWithUIBezierPath.h"//关键帧动画结合贝塞尔路径
#import "Demo_31_VirtualProperty.h"//虚拟属性
#import "Demo_32_CAAnimationGroup.h"//动画组:关键帧路径和基础动画的组合
#import "Demo_33_Transition.h"//过渡动画+UIKit动画
#import "Demo_34_RenderInContext.h"//用renderInContext:创建自定义过渡效果 
#import "Demo_35_CancleAnimation.h"//在动画过程中取消动画
#import "Demo_36_DurationAndRepeatCount.h"//动画的持续和重复
#import "Demo_37_Autoreverses.h"//摆动门的动画
#import "Demo_38_TimeOffsetAndSpeed.h"//相对时间
#import "Demo_39_TimeOff.h"//手动动画
#import "Demo_40_TimingFunction.h"//缓冲函数
#import "Demo_41_TimingFunctions.h"//缓冲和关键帧动画
#import "Demo_42_CAMediaTimingFunction.h" // 使用UIBezierPath绘制CAMediaTimingFunction
#import "Demo_43_ComplexAnimationLine.h"//使用关键帧实现反弹球的动画
#import "Demo_44_LineBuffer.h"// 线性缓冲
#import "Demo_45_NSTimerEaseOutBall.h"//NSTimer实现动感弹球效果
#import "Demo_46_CADisplayLink.h"//CADisplayLink实现动感弹球效果
#import "Demo_47_ViewController.h"//instruments绘图性能分析
#import "Demo_48_Draw_CoreGraphics.h"//使用Core Graphics绘图
#import "Demo_49_Draw_CAShapeLayer.h"//使用Core Animation绘图
#import "Demo_50_BlackBorad.h"//"黑板"
#import "Demo_51_imageIO.h"//图片的IO
#import "Demo_52_CATiledLayer.h"//CATiledLayer异步加载和显示大型图片
#import "Demo_53_NSCache.h"//NSCache缓存

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) Demo_52_CATiledLayer *VC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CoreAnimation系列";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.dataArray = [NSMutableArray arrayWithObjects:
                      @"Demo_01_Layer",
                      @"Demo_02_Contents",
                      @"Demo_03_ContentsRect",
                      @"Demo_04_ContentsCenter",
                      @"Demo_05_DrawLayer",
                      @"Demo_06_AnchorPoint",
                      @"Demo_07_ZPosition",
                      @"Demo_08_ContainsPoint",
                      @"Demo_09_ShadowPath",
                      @"Demo_10_Mask",
                      @"Demo_11_ShouldRasterize",
                      @"Demo_12_AffineTransform",
                      @"Demo_13_Mix_AffineTransform",
                      @"Demo_14_CATransform3D",
                      @"Demo_15_SublayerTransform",
                      @"Demo_16_Mutable_Rotation",
                      @"Demo_17_Mutable_Rotation_3D",
                      @"Demo_18_Cube",
                      @"Demo_19_CAShapeLayer",
                      @"Demo_20_CATextLayer",
                      @"Demo_21_CATransformLayer",
                      @"Demo_22_CAGradientLayer",
                      @"Demo_23_CAReplicatorLayer",
                      @"Demo_24_CAEmitterLayer",
                      @"Demo_25_CAEAGLLayer",
                      @"Demo_26_IntentAnimation",
                      @"Demo_27_IntentAnimation_Principle",
                      @"Demo_28_PresentationLayer",
                      @"Demo_29_CAKeyframeAnimation",
                      @"Demo_30_CAKeyfraneAnimationWithUIBezierPath",
                      @"Demo_31_VirtualProperty",
                      @"Demo_32_CAAnimationGroup",
                      @"Demo_33_Transition",
                      @"Demo_34_RenderInContext",
                      @"Demo_35_CancleAnimation",
                      @"Demo_36_DurationAndRepeatCount",
                      @"Demo_37_Autoreverses",
                      @"Demo_38_TimeOffsetAndSpeed",
                      @"Demo_39_TimeOff",
                      @"Demo_40_TimingFunction",
                      @"Demo_41_TimingFunctions",
                      @"Demo_42_CAMediaTimingFunction",
                      @"Demo_43_ComplexAnimationLine",
                      @"Demo_44_LineBuffer",
                      @"Demo_45_NSTimerEaseOutBall",
                      @"Demo_46_CADisplayLink",
                      @"Demo_47_ViewController",
                      @"Demo_48_Draw_CoreGraphics",
                      @"Demo_49_Draw_CAShapeLayer",
                      @"Demo_50_BlackBorad",
                      @"Demo_51_imageIO",
                      @"Demo_52_CATiledLayer",
                      @"Demo_53_NSCache",
                      nil];
    
    _VC = [Demo_52_CATiledLayer new];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id viewController = nil;
    if (indexPath.row == 51) {
        viewController = _VC;
    } else {
        viewController = [[NSClassFromString(self.dataArray[indexPath.row]) alloc]init];
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

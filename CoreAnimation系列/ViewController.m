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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray arrayWithObjects:
                      [Demo_01_Layer new],
                      [Demo_02_Contents new],
                      [Demo_03_ContentsRect new],
                      [Demo_04_ContentsCenter new],
                      [Demo_05_DrawLayer new],
                      [Demo_06_AnchorPoint new],
                      [Demo_07_ZPosition new],
                      [Demo_08_ContainsPoint new],
                      [Demo_09_ShadowPath new],
                      [Demo_10_Mask new],
                      [Demo_11_ShouldRasterize new],
                      [Demo_12_AffineTransform new],
                      [Demo_13_Mix_AffineTransform new],
                      [Demo_14_CATransform3D new],
                      [Demo_15_SublayerTransform new],
                      [Demo_16_Mutable_Rotation new],
                      [Demo_17_Mutable_Rotation_3D new],
                      [Demo_18_Cube new],
                      [Demo_19_CAShapeLayer new],
                      [Demo_20_CATextLayer new],
                      [Demo_21_CATransformLayer new],
                      [Demo_22_CAGradientLayer new],
                      [Demo_23_CAReplicatorLayer new],
                      [Demo_24_CAEmitterLayer new],
                      [Demo_25_CAEAGLLayer new],
                      [Demo_26_IntentAnimation new],
                      [Demo_27_IntentAnimation_Principle new],
                      [Demo_28_PresentationLayer new],
                      [Demo_29_CAKeyframeAnimation new],
                      [Demo_30_CAKeyfraneAnimationWithUIBezierPath new],
                      [Demo_31_VirtualProperty new],
                      [Demo_32_CAAnimationGroup new],
                      nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = NSStringFromClass([self.dataArray[indexPath.row] class]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:self.dataArray[indexPath.row] animated:YES];
}


@end

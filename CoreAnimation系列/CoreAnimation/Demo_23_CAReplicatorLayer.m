//
//  Demo_23_CAReplicatorLayer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/18.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_23_CAReplicatorLayer.h"

@interface Demo_23_CAReplicatorLayer ()
@property (nonatomic, strong) UIView *containerView;
@end

@implementation Demo_23_CAReplicatorLayer

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     CAReplicatorLayer的目的是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换。
     
     CAReplicatorLayer生成十个图层组成一个圆圈。instanceCount属性指定了图层需要重复多少次。instanceTransform指定了一个CATransform3D3D变换（这种情况下，下一图层的位移和旋转将会移动到圆圈的下一个点）。
     
     变换是逐步增加的，每个实例都是相对于前一实例布局。这就是为什么这些复制体最终不会出现在同意位置上
     
     */
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.containerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.containerView];
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    //configure the replicator
    replicator.instanceCount = 10;
    
    CATransform3D trans = CATransform3DIdentity;
    trans = CATransform3DTranslate(trans, 0, 200, 0);
    trans = CATransform3DRotate(trans, M_PI / 5, 0, 0, 1);
    trans = CATransform3DTranslate(trans, 0, -200, 0);
    
    replicator.instanceTransform = trans;
    
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
    
    /*
    当图层在重复的时候，他们的颜色也在变化：这是用instanceBlueOffset和instanceGreenOffset属性实现的。通过逐步减少蓝色和绿色通道，我们逐渐将图层颜色转换成了红色。这个复制效果看起来很酷，但是CAReplicatorLayer真正应用到实际程序上的场景比如：一个游戏中导弹的轨迹云，或者粒子爆炸（尽管iOS 5已经引入了CAEmitterLayer，它更适合创建任意的粒子效果）。除此之外，还有一个实际应用是：反射。
     */

}

@end

//
//  Demo_24_CAEmitterLayer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/18.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_24_CAEmitterLayer.h"

@interface Demo_24_CAEmitterLayer ()

@property (nonatomic,strong) CAEmitterLayer *emitterLayer;

@end

@implementation Demo_24_CAEmitterLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     iOS 5中，苹果引入了一个新的CALayer子类叫做CAEmitterLayer。CAEmitterLayer是一个高性能的粒子引擎，被用来创建实时例子动画如：烟雾，火，雨等等这些效果。
     */
    self.view.backgroundColor = [UIColor blackColor];
    
    self.emitterLayer.emitterPosition = self.view.center;
    [self.view.layer addSublayer:self.emitterLayer];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    self.emitterLayer.emitterPosition = point;
}

#pragma mark 初始化
- (CAEmitterLayer *)emitterLayer {
    if (_emitterLayer == nil) {
        _emitterLayer = [[CAEmitterLayer alloc] init];
        //设置为混合模式
        _emitterLayer.renderMode = kCAEmitterLayerAdditive;
        //生成一个发射点
        _emitterLayer.birthRate = 1;
        
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        //cell的如下值是必须要设置的，否则不会出现
        cell.contents = CFBridgingRelease([UIImage imageNamed:@"1"].CGImage);
        //粒子发射方向，与x轴的角度
        cell.emissionLongitude = M_PI_2+M_PI;
        //粒子发射方向，与y轴的角度
        cell.emissionLatitude = M_PI_2+M_PI;
        //粒子发射范围，与上一个值得正负值范围
        cell.emissionRange = M_PI;
        //移动速度
        cell.velocity = 100;
        cell.velocityRange = 80;
        //存活时间和初始速度
        cell.lifetime = 4;
        //每秒生成数
        cell.birthRate = 20;
        cell.scale = 0.2;
        [cell setName:@"cell"];
        
        _emitterLayer.emitterCells = @[cell];
    }
    return _emitterLayer;
}
@end

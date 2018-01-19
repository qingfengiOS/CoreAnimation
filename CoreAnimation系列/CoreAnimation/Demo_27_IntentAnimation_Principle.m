//
//  Demo_27_IntentAnimation_Principle.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/19.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_27_IntentAnimation_Principle.h"

@interface Demo_27_IntentAnimation_Principle ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong)  CALayer *colorLayer;
@property (nonatomic, assign)  CGFloat margin;
@end

@implementation Demo_27_IntentAnimation_Principle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _margin = 0;
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:self.containerView];
    
    [self principle];
    
   
    /*
     总结一下，我们知道了如下几点
     
     UIView关联的图层禁用了隐式动画，对这种图层做动画的唯一办法就是使用UIView的动画函数（而不是依赖CATransaction），或者继承UIView，并覆盖-actionForLayer:forKey:方法，或者直接创建一个显式动画（具体细节见第八章）。
     对于单独存在的图层，我们可以通过实现图层的-actionForLayer:forKey:委托方法，或者提供一个actions字典来控制隐式动画。
     */
    [self customAction];//自定义行为
    
}

- (void)principle {//隐式动画原理
    /*
     “我们知道Core Animation通常对CALayer的所有属性（可动画的属性）做动画，但是UIView把它关联的图层的这个特性关闭了。为了更好说明这一点，我们需要知道隐式动画是如何实现的。
     
     我们把改变属性时CALayer自动应用的动画称作行为，当CALayer的属性被修改时候，它会调用-actionForKey:方法，传递属性的名称。剩下的操作都在CALayer的头文件中有详细的说明，实质上是如下几步：
     
     1、图层首先检测它是否有委托，并且是否实现CALayerDelegate协议指定的-actionForLayer:forKey方法。如果有，直接调用并返回结果。
     2、如果没有委托，或者委托没有实现-actionForLayer:forKey方法，图层接着检查包含属性名称对应行为映射的actions字典。
     3、如果actions字典没有包含对应的属性，那么图层接着在它的style字典接着搜索属性名。
     4、最后，如果在style里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的-defaultActionForKey:方法。
     
     所以一轮完整的搜索结束之后，-actionForKey:要么返回空（这种情况下将不会有动画发生），要么是CAAction协议对应的对象，最后CALayer拿这个结果去对先前和当前的值做动画。
     
     于是这就解释了UIKit是如何禁用隐式动画的：每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，UIView对所有图层行为返回nil，但是在动画block范围之内，它就返回了一个非空值。
     */
    
    //test layer action when outside of animation block
    NSLog(@"Outside: %@", [self.containerView actionForLayer:self.containerView.layer forKey:@"backgroundColor"]);
    
    //begin animation block
    [UIView beginAnimations:nil context:nil];
    
    //test layer action when inside of animation block
    NSLog(@"Inside: %@", [self.containerView actionForLayer:self.containerView.layer forKey:@"backgroundColor"]);
    
    //end animation block
    [UIView commitAnimations];
}

- (void)customAction {//自定义行为
 
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 70.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //add a custom action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor":transition};//改变颜色会执行隐式动画，而又自定义了action，所以点一下变一下
    
//    self.colorLayer.actions = @{@"frame":transition};
    
    [self.view.layer addSublayer:self.colorLayer];
    
    UIButton *changBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changBtn.frame = CGRectMake(200, 64, 100, 50);
    [changBtn setTitle:@"changeColor" forState:UIControlStateNormal];
    [changBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changBtn];
    
    
}
- (void)change {
    
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
//    self.colorLayer.frame = CGRectMake(50.0f, 100.0f + _margin, 100.0f, 100.0f);
//    _margin += 5;
    
}

@end

//
//  Demo_02_Contents.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/15.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_02_Contents.h"

@interface Demo_02_Contents ()

@end

@implementation Demo_02_Contents

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 80, 200, 200)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    UIImage *image = [UIImage imageNamed:@"bg"];
    view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    /*
     “UIView大多数视觉相关的属性比如contentMode，对这些属性的操作其实是对对应图层的操作。”
     */
    //    view.contentMode = UIViewContentModeScaleAspectFit;
    
    /*
     “和cotentMode一样，contentsGravity的目的是为了决定内容在图层的边界中怎么对齐，我们将使用kCAGravityResizeAspect，它的效果等同于UIViewContentModeScaleAspectFit， 同时它还能在图层中等比例拉伸以适应图层的边界。”
     */
    view.layer.contentsGravity = kCAGravityResizeAspect;
    
    
    /*
     “如果contentsScale设置为1.0，将会以每个点1个像素绘制图片，如果设置为2.0，则会以每个点2个像素绘制图片，这就是我们熟知的Retina屏幕。”
     */
    view.layer.contentsGravity = kCAGravityCenter;
    view.layer.contentsScale = [UIScreen mainScreen].scale;
    
    /*
     “默认情况下，UIView仍然会绘制超过边界的内容或是子视图，在CALayer下也是这样的。
     
     UIView有一个叫做clipsToBounds的属性可以用来决定是否显示超出边界的内容，CALayer对应的属性叫做masksToBounds，把它设置为YES，就不会显示超出边界的部分”
     */
    view.layer.masksToBounds = YES;
}


@end


//
//  Demo_15_SublayerTransform.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/16.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_15_SublayerTransform.h"

@interface Demo_15_SublayerTransform ()
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIView *layerView1;
@property (nonatomic, weak) IBOutlet UIView *layerView2;

@end

@implementation Demo_15_SublayerTransform

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     当在透视角度绘图的时候，远离相机视角的物体将会变小变远，当远离到一个极限距离，它们可能就缩成了一个点，于是所有的物体最后都汇聚消失在同一个点。
     
     在现实中，这个点通常是视图的中心，于是为了在应用中创建拟真效果的透视，这个点应该聚在屏幕中点，或者至少是包含所有3D对象的视图中点。
     
     
     Core Animation定义了这个点位于变换图层的anchorPoint（通常位于图层中心，但也有例外，见Demo_06_AnchorPoint）。这就是说，当图层发生变换时，这个点永远位于图层变换之前anchorPoint的位置。
     
     当改变一个图层的position，你也改变了它的灭点，做3D变换的时候要时刻记住这一点，当你视图通过调整m34来让它更加有3D效果，应该首先把它放置于屏幕到指定位置（而不是直接改变它的position），这样所有的3D图层都共享一个灭点。
     */

    
    /*
     如果有多个视图或者图层，每个都做3D变换，那就需要分别设置相同的m34值，并且确保在变换之前都在屏幕中央共享同一个position，如果用一个函数封装这些操作的确会更加方便，但仍然有限制（例如，你不能在Interface Builder中摆放视图），这里有一个更好的方法。
     
     CALayer有一个属性叫做sublayerTransform。它也是CATransform3D类型，但和对一个图层的变换不同，它影响到所有的子图层。这意味着你可以一次性对包含这些图层的容器做变换，于是所有的子图层都自动继承了这个变换方法。
     
     相较而言，通过在一个地方设置透视变换会很方便，同时它会带来另一个显著的优势：灭点被设置在容器图层的中点，从而不需要再对子图层分别设置了。这意味着你可以随意使用position和frame来放置子图层而不需要把它们放置在屏幕中点，然后为了保证统一的灭点用变换来做平移
     
     我们来用一个demo举例说明。这里用Interface Builder并排放置两个视图，然后通过设置它们容器视图的透视变换，我们可以保证它们有相同的透视和灭点。
     */
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1 / 500.0f;
    self.containerView.layer.sublayerTransform = perspective;//简单地说：用于保证"视距"相同
    
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView1.layer.transform = transform1;
    
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.layerView2.layer.transform = transform2;
    
}

@end

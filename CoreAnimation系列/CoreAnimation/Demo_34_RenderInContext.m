//
//  Demo_34_RenderInContext.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/22.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_34_RenderInContext.h"

@interface Demo_34_RenderInContext ()
@property (weak, nonatomic) IBOutlet UIImageView *snapshotView;

@end

@implementation Demo_34_RenderInContext

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     过渡动画做基础的原则就是对原始的图层外观截图，然后添加一段动画，平滑过渡到图层改变之后那个截图的效果。如果我们知道如何对图层截图，我们就可以使用属性动画来代替CATransition或者是UIKit的过渡方法来实现动画。
     
     事实证明，对图层做截图还是很简单的。CALayer有一个-renderInContext:方法，可以通过把它绘制到Core Graphics的上下文中捕获当前内容的图片，然后在另外的视图中显示出来。如果我们把这个截屏视图置于原始视图之上，就可以遮住真实视图的所有变化，于是重新创建了一个简单的过渡效果。
     
     下面演示一个基本的实现。我们对当前视图状态截图，然后在我们改变原始视图的背景色的时候对截图快速转动并且淡出，Demo展示了我们自定义的过渡效果。
     
     为了让事情更简单，我们用UIView -animateWithDuration:completion:方法来实现。虽然用CABasicAnimation可以达到同样的效果，但是那样的话我们就需要对图层的变换和不透明属性创建单独的动画，然后当动画结束的时候在CAAnimationDelegate中把coverView从屏幕中移除
     */
    
    

}
- (IBAction)performTransition:(id)sender {
    
    //preserve the current view snapshot
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    self.snapshotView.image = coverImage;/* 获取屏幕截图 */
    
    //insert snapshot view in front of this one
    UIImageView *convertView = [[UIImageView alloc]initWithImage:coverImage];
    convertView.frame = self.view.bounds;
    [self.view addSubview:convertView];
    
    //update view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    //perform animation(anything you like)
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        convertView.transform = transform;
        convertView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        //remove the cover view now we're finished with it
        [convertView removeFromSuperview];
    }];
}




@end

//
//  Demo_33_Transition.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/22.
//  Copyright © 2018年 情风. All rights reserved.
//
// 过渡动画
#import "Demo_33_Transition.h"

@interface Demo_33_Transition ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) NSArray *images;
@end

@implementation Demo_33_Transition

- (void)viewDidLoad {
    [super viewDidLoad];

    //set up images
    self.images = @[[UIImage imageNamed:@"bg"],
                    [UIImage imageNamed:@"1"],
                    [UIImage imageNamed:@"loading_1"],
                    [UIImage imageNamed:@"air"]];
    
    
}

- (IBAction)useTransition:(id)sender {
    
    /*
     有时候对于iOS应用程序来说，希望能通过属性动画来对比较难做动画的布局进行一些改变。比如交换一段文本和图片，或者用一段网格视图来替换，等等。属性动画只对图层的可动画属性起作用，所以如果要改变一个不能动画的属性（比如图片），或者从层级关系中添加或者移除图层，属性动画将不起作用。
     
     于是就有了过渡的概念。过渡并不像属性动画那样平滑地在两个值之间做动画，而是影响到整个图层的变化。过渡动画首先展示之前的图层外观，然后通过一个交换过渡到新的外观。
     
     为了创建一个过渡动画，我们将使用CATransition，同样是另一个CAAnimation的子类，和别的子类不同，CATransition有一个type和subtype来标识变换效果。
     */
    CATransition *transtion = [[CATransition alloc]init];
    transtion.type = kCATransitionPush;
    transtion.subtype = kCATransitionFromTop;
    [self.imageView.layer addAnimation:transtion forKey:nil];
    
    //cycle to next image
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % [self.images count];
    self.imageView.image = self.images[index];
    
}

- (IBAction)useUIKit:(id)sender {//自定义动画
    /*
     UIView +transitionFromView:toView:duration:options:completion:和+transitionWithView:duration:options:animations:方法提供了Core Animation的过渡特性。但是这里的可用的过渡选项和CATransition的type属性提供的常量完全不同。
     */
    [UIView transitionWithView:self.imageView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        //cycle to next image
        UIImage *currentImage = self.imageView.image;
        NSUInteger index = [self.images indexOfObject:currentImage];
        index = (index + 1) % [self.images count];
        self.imageView.image = self.images[index];
       
    } completion:nil];
}

/*
 care：此两者都能做过渡动画但是效果不同，根据具体效果而定需要用哪种
 */
@end

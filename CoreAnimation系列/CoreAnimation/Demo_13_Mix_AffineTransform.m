//
//  Demo_13_Mix_AffineTransform.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/16.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_13_Mix_AffineTransform.h"

@interface Demo_13_Mix_AffineTransform ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation Demo_13_Mix_AffineTransform

- (void)viewDidLoad {
    [super viewDidLoad];

    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, M_PI_2 / 2);//旋转
    transform = CGAffineTransformScale(transform, 0.5, 0.5);//缩放
    transform = CGAffineTransformTranslate(transform, 200, 0);//移动
    
    self.imageView.layer.affineTransform = transform;
    
    /*
     图片向右边发生了平移，但并没有指定距离那么远（200像素），另外它还有点向下发生了平移。原因在于当你按顺序做了变换，上一个变换的结果将会影响之后的变换，所以200像素的向右平移同样也被旋转了30度，缩小了50%，所以它实际上是斜向移动了100像素”
     */

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

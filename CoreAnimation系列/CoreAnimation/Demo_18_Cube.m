//
//  Demo_18_Cube.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/16.
//  Copyright © 2018年 情风. All rights reserved.
//
// 
#import "Demo_18_Cube.h"
#import <GLKit/GLKit.h>

@interface Demo_18_Cube ()
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *faces;

@end

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@implementation Demo_18_Cube

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up the container sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1 / 500.0f;
    
    //调整“眼睛”看立方体
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, M_PI, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;//视距相同
    
    //上
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
    [self addFace:0 withTransform:transform];

    //下
    transform = CATransform3DMakeTranslation(0, 0, -50);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    //左
    transform = CATransform3DMakeTranslation(-50, 0, 0);
    transform = CATransform3DRotate(transform,-M_PI_2, 0, 1, 0);
    [self addFace:2 withTransform:transform];

    //右
    transform = CATransform3DMakeTranslation(50, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:3 withTransform:transform];

    //后
    transform = CATransform3DMakeTranslation(0, -50, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:4 withTransform:transform];
    
    //前
    transform = CATransform3DMakeTranslation(0, 50, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:5 withTransform:transform];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changeAngle:)];
    [_containerView addGestureRecognizer:pan];
    
}




/**
 添加每个面到立方体

 @param index 下标
 @param transform 3D变换
 */
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    //get the face view and add it to the container
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];
    
    CGSize size = self.containerView.bounds.size;
    face.center = CGPointMake(size.width / 2, size.height / 2);
    face.layer.transform = transform;
    
    [self applyLightToFace:face.layer];
}


/**
 添加光照阴影 （没起作用?）

 @param face layer
 */
- (void)applyLightToFace:(CALayer *)face {
    
    /*
     如果需要动态地创建光线效果，你可以根据每个视图的方向应用不同的alpha值做出半透明的阴影图层，但为了计算阴影图层的不透明度，你需要得到每个面的正太向量（垂直于表面的向量），然后根据一个想象的光源计算出两个向量叉乘结果。叉乘代表了光源和图层之间的角度，从而决定了它有多大程度上的光亮。
     
     每个面的CATransform3D都被转换成GLKMatrix4，然后通过GLKMatrix4GetMatrix3函数得出一个3×3的旋转矩阵。这个旋转矩阵指定了图层的方向，然后可以用它来得到正太向量的值
     */
    
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}
#pragma mark - 拖拽装懂cube
- (void)changeAngle:(UIPanGestureRecognizer *)sender{
    //返回视图拖动的像素
    CGPoint point =  [sender translationInView:_containerView];
    //point.x/30可以决定拖动的时候旋转的速度
    CGFloat angel = -M_PI_4 + point.x/30;
    CGFloat angel2 = -M_PI_4 - point.y/ 30 ;
    
    CATransform3D tran = CATransform3DIdentity;
    tran.m34 = -1/ 500;
    tran = CATransform3DRotate(tran, angel, 0, 1, 0);
    tran = CATransform3DRotate(tran, angel2, 1, 0, 0);
    // sublayerTransform: 它能够影响到它所有的直接子图层. 就是说可以一次性对这些图层的容器做变换, 然后所有的子图层都集成这个变换方法.
    _containerView.layer.sublayerTransform = tran;
    
}

/*
 把除了表面5的其他视图userInteractionEnabled属性都设置成NO来禁止事件传递。或者简单通过代码把视图3覆盖在视图6上。无论怎样都可以点击按钮了
 */
#pragma mark - Actions
- (IBAction)one:(id)sender {
    
}
- (IBAction)two:(id)sender {
    
}
- (IBAction)three:(id)sender {
    
}
- (IBAction)four:(id)sender {
    
}
- (IBAction)five:(id)sender {
    
}
- (IBAction)sex:(id)sender {
    
}

@end

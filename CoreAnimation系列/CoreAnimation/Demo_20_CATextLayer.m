//
//  Demo_20_CATextLayer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/16.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_20_CATextLayer.h"
#import "QFLayerLabel.h"

@interface Demo_20_CATextLayer ()

@property (nonatomic, strong) UIView *labelView;

@end

@implementation Demo_20_CATextLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _labelView = [[UIView alloc]initWithFrame:CGRectMake(20, 70, 300, 300)];
    [self.view addSubview:_labelView];
    
    [self CATextLayer];
    [self useLabel];
    [self replaceLabel];
}

/**
 CATextLayer 来实现一个 UILabel
 */
- (void)CATextLayer {
    //create layer
    CATextLayer *layer = [CATextLayer layer];
    layer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:layer];
    
    layer.foregroundColor = [UIColor darkGrayColor].CGColor;
    layer.alignmentMode = kCAAlignmentJustified;
    layer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    layer.font = fontRef;
    layer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"  使用CATextLayer来实现展示文字,CATextLayer要比 UILabel渲染得快得多。很少有人知道在iOS6及之前的版本,其实是通过WebKit来实现绘制的,这样就造成了当有很多文字的时候就会有极大的性能压力。而CATextLayer使用了Core text，并且渲染得非常快。(使用CATextLayer)";
    
    layer.string = text;
    
    //如果你仔细看这个文本，你会发现一个奇怪的地方:这些文本有一些像素化了。这 是因为并没有以Retina的方式渲染，第二章提到了这个 属性，用来 决定图层内容应该以怎样的分辨率来渲染。 并不关心屏幕的拉伸 因素而总是默认为1.0。如果我们想以Retina的质量来显示文字，我们就得手动地设 置 CATextLayer 的 contentsScale 属性
    layer.contentsScale = [UIScreen mainScreen].scale;
    
}

- (void)useLabel {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 350, 300, 200)];
    label.text =  @"  使用CATextLayer来实现展示文字,CATextLayer要比UILabel渲染得快得多。很少有人知道在iOS6及之前的版本,其实是通过WebKit来实现绘制的,这样就造成了当有很多文字的时候就会有极大的性能压力。而CATextLayer使用了Core text，并且渲染得非常快。(使用UILabel)";
    label.numberOfLines = 0;
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
}

- (void)replaceLabel {
    QFLayerLabel *layerLabel = [[QFLayerLabel alloc]initWithFrame:CGRectMake(20, 550, 300, 80)];
    layerLabel.textColor = [UIColor darkGrayColor];
    layerLabel.text = @"使用QFLayerLabel替换Label,而CATextLayer使用了Core text，使用CATextLayer来实现展示文字,CATextLayer要比UILabel渲染得快得多。很少有人知道在iOS6及之前的版本,其实是通过WebKit来实现绘制的,这样就造成了当有很多文字的时候就会有极大的性能压力。而CATextLayer使用了Core text，并且渲染得非常快。(QFLayerLabel)";
    layerLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:layerLabel];
}

@end


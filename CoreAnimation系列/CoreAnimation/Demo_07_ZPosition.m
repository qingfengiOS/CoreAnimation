//
//  Demo_07_ZPosition.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/15.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_07_ZPosition.h"

@interface Demo_07_ZPosition ()
@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@end

@implementation Demo_07_ZPosition

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orangeView.layer.zPosition = 1.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end


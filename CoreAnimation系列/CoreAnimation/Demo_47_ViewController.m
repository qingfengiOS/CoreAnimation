//
//  Demo_47_ViewController.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/8.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_47_ViewController.h"

@interface Demo_47_ViewController ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation Demo_47_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set up data
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 1000; i++) {
        //add name
        [array addObject:@{@"name": [self randomName], @"image": [self randomAvatar]}];
    }
    self.items = array;
    //register cell class
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}


- (NSString *)randomName {
    NSArray *first = @[@"Alice", @"Bob", @"Bill", @"Charles", @"Dan", @"Dave", @"Ethan", @"Frank"];
    NSArray *last = @[@"Appleseed", @"Bandicoot", @"Caravan", @"Dabble", @"Ernest", @"Fortune"];
    NSUInteger index1 = (rand()/(double)INT_MAX) * [first count];
    NSUInteger index2 = (rand()/(double)INT_MAX) * [last count];
    return [NSString stringWithFormat:@"%@ %@", first[index1], last[index2]];
}
- (NSString *)randomAvatar
{
    NSArray *images = @[@"air", @"bg", @"clock", @"door", @"hootel_map", @"loading_1"];
    NSUInteger index = (rand()/(double)INT_MAX) * [images count];
    return images[index];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //dequeue cell
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //load image
    NSDictionary *item = self.items[indexPath.row];
    //set image and text
    cell.imageView.image = [UIImage imageNamed:item[@"image"]];
    cell.textLabel.text = item[@"name"];
    
    //care：这里设置了阴影，导致离屏渲染，严重卡顿
    //set image shadow
    cell.imageView.layer.shadowOffset = CGSizeMake(0, 5);
    cell.imageView.layer.shadowOpacity = 0.75;
    cell.clipsToBounds = YES;
    //set text shadow
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.layer.shadowOffset = CGSizeMake(0, 2);
    cell.textLabel.layer.shadowOpacity = 0.5;
    
    /*
     解决方案：
         每一行的字符和头像在每一帧刷新的时候并不需要变，所以看起来UITableViewCell的图层非常适合做缓存。我们可以使用shouldRasterize来缓存图层内容。这将会让图层离屏之后渲染一次然后把结果保存起来，直到下次利用的时候去更新
    */
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    /*
     总结：
         我们仍然离屏绘制图层内容，但是由于显式地禁用了栅格化，Core Animation就对绘图缓存了结果，于是对提高了性能。
     */
    
    return cell;
}




@end

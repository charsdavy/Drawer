//
//  ShopListViewController.m
//  tianmao
//
//  Created by dengwei on 16/1/17.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "ShopListViewController.h"
#import "Shop.h"

#define kSubViewHeight 200

@interface ShopListViewController ()

@end

@implementation ShopListViewController

#pragma mark - 实例化视图
/**
 *  因为本视图是嵌入在另外一个视图控制器的，因此不会全屏显示，
    在实例化视图的时候，需要指定视图大小。
 */
-(void)loadView{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, kSubViewHeight) style:UITableViewStylePlain];
    
    NSLog(@"come here");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    Shop *s = self.shopList[indexPath.row];
    cell.textLabel.text = s.name;
    cell.imageView.image = s.image;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

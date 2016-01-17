//
//  ShopListViewController.m
//  tianmao
//
//  Created by dengwei on 16/1/17.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "ShopListViewController.h"
#import "Shop.h"
#import "ShopCell.h"

#define kSubViewHeight 200
#define kRow 3

@interface ShopListViewController ()<ShopCellDelegate>

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
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((self.shopList.count + kColumn - 1) / kColumn);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.delegate = self;
    }

    // 截出每一行所需要的Shop对象
    NSInteger location = indexPath.row * kColumn;
    NSInteger length = kColumn;
    if (location + length >= self.shopList.count) {
        length = self.shopList.count - location;
    }
    NSArray *parts = [self.shopList subarrayWithRange:NSMakeRange(location, length)];
    
    // 设置Shops和行号
    [cell setShops:parts row:(int)indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kShopCellHeight;
}

#pragma mark - ShopCellDelegate
- (void)shop:(Shop *)shop clickAtRow:(int)row column:(int)column {
    NSLog(@"%@ row:%i column:%i", shop.name, row, column);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

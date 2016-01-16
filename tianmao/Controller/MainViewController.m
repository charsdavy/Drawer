//
//  MainViewController.m
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "MainViewController.h"
#import "ShopTypeCell.h"
#import "FolderView.h"
#import "ShopType.h"

//#define kSubViewHeight 200

static NSString *cellId = @"myCell";

@interface MainViewController ()
/**
 *  动画的表格行
 */
//@property (nonatomic, strong) NSMutableArray *animationRows;

/**
 *  子视图
 */
//@property (nonatomic, strong) UIView *subView;

@property (nonatomic, strong) NSArray *dataList;
@end

@implementation MainViewController

/**
 *  在UITableViewController中，如果要实例化视图，直接实例化self.tableView即可。
 *  如果要使用默认的平板表格UITableViewStylrPlain，可以不用重写loadView方法。
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kSubViewHeight)];
//    subView.backgroundColor = [UIColor lightGrayColor];
//    //说明：能用addSubview方法吗？
//    self.subView = subView;
    
    [self initDataList];
    
    //给tableView注册ShopTypeCell类
    [self.tableView registerClass:[ShopTypeCell class] forCellReuseIdentifier:cellId];
}

#pragma mark - 实例化视图
-(void)loadView{
    self.tableView = [[FolderView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
}

#pragma mark - 初始化数据
-(void)initDataList{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        ShopType *st = [ShopType shopTypeWithDict:dict];
        [arrayM addObject:st];
    }
    _dataList = arrayM;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    ShopType *st = self.dataList[indexPath.row];

    cell.textLabel.text = st.name;
    cell.imageView.image = st.image;
    cell.detailTextLabel.text = st.detail;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FolderView *folder = (FolderView *)tableView;
    
    ShopType *shopType = self.dataList[indexPath.row];
    [folder operateFolderAtIndexPath:indexPath shopList:shopType.subShops];
}

#if 0
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *  选中某一行表格后，将下方的表格向下移动kSubViewHeight的高度
     *  可以通过tableView的indexPathsForVisibleRows获取到当前屏幕上所有显示的行
     */
    
    //处理关闭抽屉，释放掉animationRows
    /**
     *  如果animationRows数组不存在，说明没有打开抽屉，做打开抽屉的操作。
        如果animationRows数组已经存在，说明抽屉已经打开，做关闭抽屉操作。
     */
    if ([self.animationRows count] != 0) {
        /**
         关闭抽屉，就是把所有动画行复位
         要复位，需要知道动画行的初始位置
         要在挪动表格行之前纪录对应的初始位置Y值
         注意：tag是整数，Y值是浮点数，因此不能用tag记录
        */
        
        [UIView animateWithDuration:1.0f animations:^{
            //1)遍历数组，还原所有动画行的Y值
            for (NSIndexPath *path in self.animationRows) {
                ShopTypeCell *cell = (ShopTypeCell *)[tableView cellForRowAtIndexPath:path];
                CGRect frame = cell.frame;
                frame.origin.y = cell.originY;
                [cell setFrame:frame];
            }
        } completion:^(BOOL finished) {
            //2)删除animationRows
            [self.animationRows removeAllObjects];
            //3)从主视图中移除子视图
            [self.subView removeFromSuperview];
        }];        
        
        return;
    }
    
    //新建一个数组，可以把所有可能动画的表格行的iindexPath全部记录下来
    NSMutableArray *array = [NSMutableArray arrayWithArray:[tableView indexPathsForVisibleRows]];
    self.animationRows = array;
    /**
     *  1.下方的空间足够大，只要挪动选中行下方的表格即可
     *  2.下方的空间不够大，上面的要挪多少，下边要挪多少？
     */
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //1)选中单元格的y
    CGFloat cellY = cell.frame.origin.y;
    //2)选中单元格的行高
    CGFloat cellHeight = cell.frame.size.height;
    //3)准备插入子视图的Y
    CGFloat subViewY = cellY + cellHeight;
    //4)屏幕的高度
    CGFloat tableHeight = self.tableView.frame.size.height;
    //5)表格的偏移
    CGFloat offsetY = self.tableView.contentOffset.y;
    
    //判断空间是否足够
    if (tableHeight - subViewY + offsetY < kSubViewHeight) {
        NSLog(@"空间不足");
        CGFloat up = tableHeight + offsetY - kSubViewHeight - subViewY;
        subViewY = tableHeight + offsetY - kSubViewHeight;
        CGFloat down = kSubViewHeight + up;
        [UIView animateWithDuration:1.0f animations:^{
            //遍历数组，挪动单元格
            for (NSIndexPath *path in array) {
                //取出要挪动的表格行
                ShopTypeCell *cell = (ShopTypeCell *)[tableView cellForRowAtIndexPath:path];
                //记录初始Y值
                cell.originY = cell.frame.origin.y;

                CGRect newFrame = cell.frame;
                //小于或等于选中行的向上挪
                if (path.row <= indexPath.row) {
                    newFrame.origin.y += up;
                }else{
                    //大于的向下
                    newFrame.origin.y += down;
                }
                [cell setFrame:newFrame];
            }
        }];
        
    }else{
        NSLog(@"空间足够");
        [UIView animateWithDuration:1.0f animations:^{
            for (NSIndexPath *path in array) {
                //1.取出要挪动的表格行
                ShopTypeCell *cell = (ShopTypeCell *)[tableView cellForRowAtIndexPath:path];
                //记录初始Y值
                cell.originY = cell.frame.origin.y;

                if (path.row > indexPath.row) {
                    //2.挪动表格行，挪动位置：frame，center
                    //1)当前的frame
                    CGRect frame = cell.frame;
                    frame.origin.y += kSubViewHeight;
                    [cell setFrame:frame];
                }
            }
        }];
    }
    //设置子视图
    [self.view insertSubview:self.subView atIndex:0];
    CGRect subViewFrame = self.view.frame;
    subViewFrame.origin.y = subViewY;
    [self.subView setFrame:subViewFrame];
}
#endif

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

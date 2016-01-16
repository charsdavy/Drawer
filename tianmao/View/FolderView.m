//
//  FolderView.m
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "FolderView.h"
#import "ShopTypeCell.h"

#define kProductCellHeight 80
#define kSubViewHeight 200

@interface FolderView ()

/**
 *  动画的表格行
 */
@property (nonatomic, strong) NSMutableArray *animationRows;

@end

@implementation FolderView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //1.设置背景图片
        UIImage *image = [UIImage imageNamed:@"tmall_bg_furley.png"];
        //使用图片屏幕背景
        [self setBackgroundColor:[UIColor colorWithPatternImage:image]];
        
        //2.设置表格行高
        self.rowHeight = kProductCellHeight;
        
        //3.取消垂直滚动条
        self.showsVerticalScrollIndicator = NO;
        
        //4.取消弹簧效果
        [self setBounces:NO];
        
        //5.顶部多滚出部分区域
        //self.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    return self;
}

#pragma mark - 抽屉操作
-(void)operateFolderAtIndexPath:(NSIndexPath *)indexPath shopList:(NSArray *)shopList{
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
                ShopTypeCell *cell = (ShopTypeCell *)[self cellForRowAtIndexPath:path];
                CGRect frame = cell.frame;
                frame.origin.y = cell.originY;
                [cell setFrame:frame];
            }
        } completion:^(BOOL finished) {
            //2)删除animationRows
            [self.animationRows removeAllObjects];
            //3)从主视图中移除子视图
            //[self.subView removeFromSuperview];
        }];
        
        return;
    }
    
    //新建一个数组，可以把所有可能动画的表格行的iindexPath全部记录下来
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self indexPathsForVisibleRows]];
    self.animationRows = array;
    /**
     *  1.下方的空间足够大，只要挪动选中行下方的表格即可
     *  2.下方的空间不够大，上面的要挪多少，下边要挪多少？
     */
    
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    //1)选中单元格的y
    CGFloat cellY = cell.frame.origin.y;
    //2)选中单元格的行高
    CGFloat cellHeight = cell.frame.size.height;
    //3)准备插入子视图的Y
    CGFloat subViewY = cellY + cellHeight;
    //4)屏幕的高度
    CGFloat tableHeight = self.frame.size.height;
    //5)表格的偏移
    CGFloat offsetY = self.contentOffset.y;
    
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
                ShopTypeCell *cell = (ShopTypeCell *)[self cellForRowAtIndexPath:path];
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
                ShopTypeCell *cell = (ShopTypeCell *)[self cellForRowAtIndexPath:path];
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
//    [self.view insertSubview:self.subView atIndex:0];
//    CGRect subViewFrame = self.view.frame;
//    subViewFrame.origin.y = subViewY;
//    [self.subView setFrame:subViewFrame];
}

@end

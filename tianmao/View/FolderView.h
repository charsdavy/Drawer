//
//  FolderView.h
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FolderView : UITableView

/**
 *  操作抽屉
 */
-(void)operateFolderAtIndexPath:(NSIndexPath *)indexPath shopList:(NSArray *)shopList;

@end

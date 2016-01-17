//
//  ShopCell.h
//  tianmao
//
//  Created by dengwei on 16/1/17.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kShopCellHeight 70
#define kColumn 4

@class Shop;

@protocol ShopCellDelegate <NSObject>

- (void)shop:(Shop *)shop clickAtRow:(int)row column:(int)column;
@end

@interface ShopCell : UITableViewCell

@property (nonatomic, weak) id<ShopCellDelegate> delegate;

- (void)setShops:(NSArray *)shops row:(int)row;

@end

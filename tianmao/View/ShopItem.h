//
//  ShopItem.h
//  tianmao
//
//  Created by dengwei on 16/1/17.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Shop;
@interface ShopItem : UIButton

@property (nonatomic, assign) int row;
@property (nonatomic, assign) int column;
@property (nonatomic, strong) Shop *shop;

@end

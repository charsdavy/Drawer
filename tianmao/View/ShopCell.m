//
//  ShopCell.m
//  tianmao
//
//  Created by dengwei on 16/1/17.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "ShopCell.h"
#import "Shop.h"
#import "ShopItem.h"

#define kTagPrefix 10

@implementation ShopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat width = self.contentView.bounds.size.width / kColumn;
        for (int i = 0; i < kColumn; i++) {
            CGRect frame = CGRectMake(i * width, 0, width, kShopCellHeight);
            ShopItem *item = [[ShopItem alloc] initWithFrame:frame];
            item.tag = kTagPrefix + i;
            item.column = i;
            [item addTarget:self action:@selector(shopClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:item];
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone; //不显示选中的样式
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark 监听商品点击
- (void)shopClick:(ShopItem *)item {
    if ([self.delegate respondsToSelector:@selector(shop:clickAtRow:column:)]) {
        [self.delegate shop:item.shop clickAtRow:item.row column:item.column];
    }
}

- (void)setShops:(NSArray *)shops row:(int)row{
    NSUInteger count = shops.count;
    
    for (int i = 0; i < kColumn; i++) {
        ShopItem *item = (ShopItem *)[self viewWithTag:kTagPrefix + i];
        item.row = row;
        if (i >= count) {
            item.hidden = YES;
        } else {
            item.hidden = NO;
            item.shop = [shops objectAtIndex:i];
        }
    }
}

@end

//
//  ShopItem.m
//  tianmao
//
//  Created by dengwei on 16/1/17.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "ShopItem.h"
#import "Shop.h"

#define kIconPercent 0.75
#define kIconMargin 0.05

@implementation ShopItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 图标
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // 文字
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setShop:(Shop *)shop {
    _shop = shop;
    
    // 图标
    [self setImage:[UIImage imageNamed:shop.imageName] forState:UIControlStateNormal];
    // 文字
    [self setTitle:shop.name forState:UIControlStateNormal];
}

#pragma mark 设置图标的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat height = contentRect.size.height * (kIconPercent - kIconMargin);
    
    return CGRectMake(0, contentRect.size.height * kIconMargin, contentRect.size.width, height);
}

#pragma mark 设置文字的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, contentRect.size.height * kIconPercent, contentRect.size.width, contentRect.size.height * (1 - kIconPercent));
}

@end

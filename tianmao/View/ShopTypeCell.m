//
//  ShopTypeCell.m
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "ShopTypeCell.h"

@implementation ShopTypeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        //表格行的初始化设置
        //1)设置表格行的背景图片
        UIImage *image = [UIImage imageNamed:@"tmall_bg_main.png"];
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:image];
        //2)清空Label的背景颜色
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        //3)设置字体大小
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        //4)设置表格选择样式
        self.selectionStyle = UITableViewCellSelectionStyleNone; //不显示选中的样式
    }
    return self;
}

@end

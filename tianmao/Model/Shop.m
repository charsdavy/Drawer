//
//  Shop.m
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "Shop.h"

@implementation Shop

+(instancetype)shopWithDict:(NSDictionary *)dict{
    Shop *s = [[Shop alloc] initWithDict:dict];
    s.classId = dict[@"classID"];
    return s;
}

@end

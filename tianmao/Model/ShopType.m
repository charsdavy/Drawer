//
//  ShopType.m
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "ShopType.h"
#import "Shop.h"

@implementation ShopType

+(instancetype)shopTypeWithDict:(NSDictionary *)dict{
    ShopType *st = [[ShopType alloc] initWithDict:dict];
    
    NSArray *array = dict[@"subClass"];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    NSMutableString *stringM = [NSMutableString string];
//    方式一
//    NSInteger i = 0;
//    for (NSDictionary *dict in array) {
//        Shop *s = [Shop shopWithDict:dict];
//        [arrayM addObject:s];
//        
//        //生成描述字符串
//        if (i < 2) {
//            [stringM appendFormat:@"%@/", s.name];
//        }else if (i == 2){
//            [stringM appendString:s.name];
//        }
//        i++;
//    }

    //方式二
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Shop *s = [Shop shopWithDict:obj];
        [arrayM addObject:s];
        
        //生成描述字符串
        if (idx < 2) {
            [stringM appendFormat:@"%@/", s.name];
        }else if (idx == 2){
            [stringM appendString:s.name];
        }
    }];
    
    st.subShops = arrayM;
    st.detail = stringM;
    
    return st;
}

@end

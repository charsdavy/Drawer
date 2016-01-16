//
//  ShopType.h
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "BaseModel.h"

@interface ShopType : BaseModel

@property (nonatomic, strong) NSArray *subShops;

/**
 *  描述字符串
 */
@property (nonatomic, strong) NSString *detail;

+(instancetype)shopTypeWithDict:(NSDictionary *)dict;
@end

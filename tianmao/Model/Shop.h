//
//  Shop.h
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "BaseModel.h"

@interface Shop : BaseModel

@property (nonatomic, strong) NSString *classId;

+(instancetype)shopWithDict:(NSDictionary *)dict;

@end

//
//  BaseModel.m
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.name = dict[@"name"];
        self.image = [UIImage imageNamed:dict[@"imageName"]];
        self.imageName = dict[@"imageName"];
        self.imageUrl = dict[@"imageUrl"];
    }
    return self;
}

@end

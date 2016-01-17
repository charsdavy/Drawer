//
//  BaseModel.h
//  tianmao
//
//  Created by dengwei on 16/1/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imageUrl;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end

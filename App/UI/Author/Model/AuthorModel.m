//
//  AuthorModel.m
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "AuthorModel.h"

@implementation AuthorModel

+ (instancetype)tgWithDict:(NSDictionary *)dict
{
    AuthorModel *author = [[self alloc] init];
    [author setValuesForKeysWithDictionary:dict];
    return author;
}

@end

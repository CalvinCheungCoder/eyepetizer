//
//  AuthorModel.m
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "AuthorModel.h"

@implementation AuthorModel

+ (instancetype)tgWithDict:(NSDictionary *)dict
{
    AuthorModel *author = [[self alloc] init];
    [author setValuesForKeysWithDictionary:dict];
    return author;
}

@end

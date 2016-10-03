//
//  AuthorModel.h
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import <Foundation/Foundation.h>

@interface AuthorModel : NSObject

// icon
@property (nonatomic, copy) NSString *iconImage;
// 作者
@property (nonatomic, copy) NSString *authorLabel;
// 视频数量
@property (nonatomic, copy) NSString *videoCount;
// 简介
@property (nonatomic, copy) NSString *desLabel;
// ID
@property (nonatomic, copy) NSString *authorId;
// actionUrl
@property (nonatomic, copy) NSString *actionUrl;

+ (instancetype)tgWithDict:(NSDictionary *)dict;

@end

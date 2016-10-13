//
//  AuthorDetailController.h
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import <UIKit/UIKit.h>

@interface AuthorDetailController : UIViewController

@property (nonatomic, copy) NSString *authorId;

// 作者信息
@property (nonatomic, copy) NSString *authorName;

@property (nonatomic, copy) NSString *authorDesc;

@property (nonatomic, copy) NSString *authorIcon;

@end

//
//  HeadView.h
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import <UIKit/UIKit.h>

@interface HeadView : UIView

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *NameLab;

@property (nonatomic, strong) UILabel *contentLab;

@end

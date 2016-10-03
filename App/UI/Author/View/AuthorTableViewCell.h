//
//  AuthorTableViewCell.h
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import <UIKit/UIKit.h>

@interface AuthorTableViewCell : UITableViewCell

// icon
@property (nonatomic, strong) UIImageView *iconImage;
// 作者
@property (nonatomic, strong) UILabel *authorLabel;
// 视频数量
@property (nonatomic, strong) UILabel *videoCount;
// 简介
@property (nonatomic, strong) UILabel *desLabel;


@end

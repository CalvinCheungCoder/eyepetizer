//
//  VideoPlayViewController.h
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import <UIKit/UIKit.h>

@interface VideoPlayViewController : UIViewController

// 视频地址
@property(nonatomic,strong) NSString *UrlString;
// 视频标题
@property(nonatomic,strong) NSString *titleStr;
// 视频时长
@property(nonatomic, assign) double duration;

@end

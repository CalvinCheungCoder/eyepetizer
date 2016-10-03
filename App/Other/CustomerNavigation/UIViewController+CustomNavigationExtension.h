//
//  UIViewController+CustomNavigationExtension.h
//  CustomTransitions
//
//  Created by CalvinCheung on 16/9/29.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"

@interface UIViewController (CustomNavigationExtension)

@property (nonatomic, assign) BOOL Custom_fullScreenPopGestureEnabled;

@property (nonatomic, weak) CustomNavigationController *Custom_navigationController;

@end

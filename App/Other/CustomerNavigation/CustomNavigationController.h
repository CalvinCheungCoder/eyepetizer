//
//  CustomNavigationController.h
//  CustomTransitions
//
//  Created by CalvinCheung on 16/9/29.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import <UIKit/UIKit.h>

@interface CustomWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (CustomWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface CustomNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *Custom_viewControllers;

@end

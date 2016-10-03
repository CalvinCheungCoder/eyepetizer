//
//  UIViewController+CustomNavigationExtension.m
//  CustomTransitions
//
//  Created by CalvinCheung on 16/9/29.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "UIViewController+CustomNavigationExtension.h"
#import <objc/runtime.h>


@implementation UIViewController (CustomNavigationExtension)

- (BOOL)Custom_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCustom_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(Custom_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (CustomNavigationController *)Custom_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCustom_navigationController:(CustomNavigationController *)navigationController {
    objc_setAssociatedObject(self, @selector(Custom_navigationController), navigationController, OBJC_ASSOCIATION_ASSIGN);
}

@end

//
//  MeNextViewController.m
//  App
//
//  Created by CalvinCheung on 16/10/3.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "MeNextViewController.h"

@interface MeNextViewController ()

@end

@implementation MeNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RandomColor;
    
    self.title = self.pageTitle;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont fontWithName:MyChinFont size:16.f],
       
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}


@end

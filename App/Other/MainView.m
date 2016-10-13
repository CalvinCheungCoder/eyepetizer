//
//  MainView.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "MainView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "MyHelper.h"
#import "CustomNavigationController.h"

@interface MainView ()

@property (nonatomic,strong)NSArray *Arrs;

@end

@implementation MainView

- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建子控制器
    [self createSubViewControllers];
    //设置所有的、分栏元素项
    [self setTabBarItems];
}

- (void)createSubViewControllers{
    
    OneViewController *One = [[OneViewController alloc]init];
    CustomNavigationController *navi = [[CustomNavigationController alloc]initWithRootViewController:One];
    navi.fullScreenPopGestureEnabled = YES;
    
    TwoViewController *Two = [[TwoViewController alloc]init];
    CustomNavigationController *navitwo = [[CustomNavigationController alloc]initWithRootViewController:Two];
    navitwo.fullScreenPopGestureEnabled = YES;
    
    ThreeViewController *Three = [[ThreeViewController alloc]init];
    CustomNavigationController *navithree = [[CustomNavigationController alloc]initWithRootViewController:Three];
    navithree.fullScreenPopGestureEnabled = YES;
    
    FourViewController *Four = [[FourViewController alloc]init];
    CustomNavigationController *naviFour = [[CustomNavigationController alloc]initWithRootViewController:Four];
    naviFour.fullScreenPopGestureEnabled = YES;
    
    self.viewControllers = @[navi,navitwo,navithree,naviFour];
}

- (void)setTabBarItems{
    
    NSArray *titleArr = @[@"精选",@"发现",@"作者",@"我的"];
    NSArray *normalImgArr = @[@"ali1",@"011",@"win1",@"my1"];
    NSArray *selectedImgArr = @[@"aliSelete1",@"01Selete1",@"winSelete1",@"mySelete1"];
    //循环设置信息
    for (int i = 0; i<4; i++) {
        UIViewController *vc = self.viewControllers[i];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] selectedImage:[[UIImage imageNamed:selectedImgArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
        vc.tabBarItem.tag = i;
    }
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
    //self.navigationController.navigationBar 这个的话会有一个专题改不了，所以这用最高权限
    //获取导航条最高权限
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}


@end

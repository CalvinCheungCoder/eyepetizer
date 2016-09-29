//
//  MainView.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "MainView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "MyHelper.h"
#import "NavViewController.h"
#import "CustomNavigationController.h"

@interface MainView ()

@property (nonatomic,strong)NSArray *Arrs;

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建子控制器
    [self createSubViewControllers];
    //设置所有的、分栏元素项
    [self setTabBarItems];
    
    // 去除tabbar细线
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
}

-(void)createSubViewControllers{
    
    OneViewController *One = [[OneViewController alloc]init];
    NavViewController *navi = [[NavViewController alloc]initWithRootViewController:One];
    
    TwoViewController *Two = [[TwoViewController alloc]init];
    CustomNavigationController *navitwo = [[CustomNavigationController alloc]initWithRootViewController:Two];
    navitwo.fullScreenPopGestureEnabled = YES;
    
    ThreeViewController *Three = [[ThreeViewController alloc]init];
    NavViewController *navithree = [[NavViewController alloc]initWithRootViewController:Three];
    
    FourViewController *Four = [[FourViewController alloc]init];
//    UINavigationController *naviFour = [[UINavigationController alloc]initWithRootViewController:Four];
    
    self.viewControllers = @[navi,navitwo,navithree,Four];
}

-(void)setTabBarItems{
    
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

//
//  HelpViewController.m
//  XieYingEchoPlay
//
//  Created by 张东良 on 15/12/22.
//  Copyright © 2015年 张东良. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()


@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNavigationLeftButton:(id)view {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)createNavigationLeftButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)createNavigationRightButton:(id)view {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createNavigationRightButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    self.navigationItem.rightBarButtonItem = rightItem;
}

@end

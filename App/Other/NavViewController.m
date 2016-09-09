//
//  NavViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/6.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:@"SnellRoundhand-Bold" size:16];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
}


@end

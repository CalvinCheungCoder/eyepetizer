//
//  FourViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "FourViewController.h"
#import "MyTableViewCell.h"

@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIView *footView;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    
    [self setTaleView];
    
}

-(void)setTaleView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.rowHeight = 70;
    [_tableView setTableHeaderView:self.headView];
    [_tableView setTableFooterView:self.footView];
    [self.view addSubview:_tableView];
}

#pragma mark -- TableViewDeletage & Datasouth
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *listArr = [NSArray arrayWithObjects:@"我的消息",@"我的缓存",@"功能开关",@"我要投稿",@"意见反馈", nil];
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label.text = listArr[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 40, 10, 80, 80)];
    [headBtn setBackgroundColor:[UIColor grayColor]];
    headBtn.layer.cornerRadius = 40;
    headBtn.layer.masksToBounds = YES;
    [self.headView addSubview:headBtn];
    
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, headBtn.bottom + 10, ScreenWidth - 20, 20)];
    headLabel.text = @"点击登录后可评论";
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.textColor = [UIColor grayColor];
    headLabel.font = [UIFont systemFontOfSize:10.f];
    [self.headView addSubview:headLabel];
    
    UIButton *shoucangBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4 - 40, headLabel.bottom + 20, 80, 20)];
    [shoucangBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
    [shoucangBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    shoucangBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.headView addSubview:shoucangBtn];
    
    UIButton *pinglunBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*3 - 40, headLabel.bottom + 20, 80, 20)];
    [pinglunBtn setTitle:@"我的评论" forState:UIControlStateNormal];
    [pinglunBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    pinglunBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.headView addSubview:pinglunBtn];
    
    UIButton *topLine = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2, shoucangBtn.top - 5, 0.5, 30)];
    [topLine setBackgroundColor:[UIColor grayColor]];
    [self.headView addSubview:topLine];
    
    UIButton *Line = [[UIButton alloc]initWithFrame:CGRectMake(0, shoucangBtn.bottom + 10, ScreenWidth, 0.5)];
    [Line setBackgroundColor:[UIColor grayColor]];
    [self.headView addSubview:Line];
    
    return self.headView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    label.text = @"version 2.7.0 build 1305";
    label.font = [UIFont systemFontOfSize:12.f];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.footView addSubview:label];
    
    return self.footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 40;
}



@end

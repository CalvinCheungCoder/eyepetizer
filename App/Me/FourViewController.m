//
//  FourViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "FourViewController.h"
#import "MyHelper.h"
#import "Wave.h"

@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) Wave *headerView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) NSArray *listArr;


@end

@implementation FourViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, ScreenHeight - 244) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setHeadView];
    
    [self.view addSubview:self.tableView];
}

-(void)setHeadView{
    
    _headerView = [[Wave alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    _headerView.backgroundColor = RGBAColor(248, 64, 87, 1);
    [_headerView addSubview:self.iconImageView];
    __weak typeof(self)weakSelf = self;
    _headerView.waveBlock = ^(CGFloat currentY){
        CGRect iconFrame = [weakSelf.iconImageView frame];
        iconFrame.origin.y = CGRectGetHeight(weakSelf.headerView.frame)-CGRectGetHeight(weakSelf.iconImageView.frame)+currentY-weakSelf.headerView.waveHeight;
        weakSelf.iconImageView.frame  =iconFrame;
    };
    [_headerView startWaveAnimation];
    [self.view addSubview:_headerView];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-30, 140, 60, 60)];
    _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImageView.layer.borderWidth = 2;
    _iconImageView.layer.cornerRadius = 20;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.image = [UIImage imageNamed:@"Login_BKG"];
    [self.view addSubview:_iconImageView];
}


#pragma mark -- TableViewDeletage & Datasouth
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _listArr = [NSArray arrayWithObjects:@"相册",@"收藏",@"钱包",@"卡包", nil];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"forIndexPath:indexPath];
    
    cell.textLabel.text = _listArr[indexPath.row];
    
    return cell;
}


@end

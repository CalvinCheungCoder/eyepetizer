//
//  OneViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "OneViewController.h"
#import "VideoListTableViewCell.h"
#import "DailyDetailViewController.h"
#import "VideoListModel.h"

@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
// 网络请求
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property (nonatomic, strong) NSMutableArray *ListArr;

@property (nonatomic, strong) NSString *NextPageStr;

@end

@implementation OneViewController

- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return NO;
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

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    // 设置TableView
    [self setTableView];
    // 获取网络数据
    [self getNetData];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self setupRefresh];
}

- (void)setupRefresh{
    
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetData];
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMore];
    }];
    
    self.tableView.mj_footer = footer;
}

// 设置TableView
- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = ScreenHeight/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
}

// 获取数据
- (void)getNetData{
    
    _ListArr = [[NSMutableArray alloc]init];
    
    //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    NSString *str = [self changeTime:[self getdate]];
    NSString *urlStr = [NSString stringWithFormat:dailyList,10,str];
    
    [Networking requestDataByURL:urlStr Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
        NSDictionary *dailyListDict = [responseObject objectForKey:@"dailyList"];
        
        for (NSDictionary *videoList in dailyListDict) {
            NSArray *temp = [videoList objectForKey:@"videoList"];
            
            for (NSDictionary *dict in temp) {
                VideoListModel *model = [[VideoListModel alloc]init];
                model.ImageView = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
                model.titleLabel = [NSString stringWithFormat:@"%@",dict[@"title"]];
                model.category = [NSString stringWithFormat:@"%@",dict[@"category"]];
                model.duration = [NSString stringWithFormat:@"%@",dict[@"duration"]];
                model.desc = [NSString stringWithFormat:@"%@",dict[@"description"]];
                model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
                NSDictionary *Dic = dict[@"consumption"];
                model.consumption = Dic;
                
                [_ListArr addObject:model];
            }
        }
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self endRefresh];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self endRefresh];
        [SVProgressHUD dismiss];
        
    }];
}

// 加载更多
- (void)loadMore{
    
    if ([self.NextPageStr isEqualToString:@"<null>"]) {
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/3)];
        footView.backgroundColor = [UIColor whiteColor];
        
        UILabel *footLabel = [[UILabel alloc]init];
        footLabel.frame = CGRectMake(0, self.view.height/2 - 10, self.view.width, 20);
        footLabel.font = [UIFont fontWithName:MyEnFontTwo size:14.f];
        footLabel.text = @"- The End -";
        [footView addSubview:footLabel];
        self.tableView.tableFooterView = footView;
         [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        
        //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"数据加载中..."];
        
        [Networking requestDataByURL:self.NextPageStr Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.NextPageStr = [responseObject objectForKey:@"nextPageUrl"];
            
            NSDictionary *dailyListDict = [responseObject objectForKey:@"dailyList"];
            for (NSDictionary *videoList in dailyListDict) {
                NSArray *temp = [videoList objectForKey:@"videoList"];
                
                for (NSDictionary *dict in temp) {
                    VideoListModel *model = [[VideoListModel alloc]init];
                    model.ImageView = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
                    model.titleLabel = [NSString stringWithFormat:@"%@",dict[@"title"]];
                    model.category = [NSString stringWithFormat:@"%@",dict[@"category"]];
                    model.duration = [NSString stringWithFormat:@"%@",dict[@"duration"]];
                    model.desc = [NSString stringWithFormat:@"%@",dict[@"description"]];
                    model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
                    NSDictionary *Dic = dict[@"consumption"];
                    model.consumption = Dic;
                    
                    [_ListArr addObject:model];
                }
            }
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            [self endRefresh];
            
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self endRefresh];
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

-(NSTimeInterval)getdate{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]* 1000;
    return a;
}

// 获取当天的时间
-(NSString *)changeTime:(NSTimeInterval)time{
    
    time = time - 86400000 *5;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time/ 1000.0 ];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyyMMdd"];
    NSString *str  = [objDateformat stringFromDate: date];
    return str;
}

#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[VideoListTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    VideoListModel *model = _ListArr[indexPath.row];
    
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageView]];
    cell.titleLabel.text = model.titleLabel;
    cell.messageLabel.text = [NSString stringWithFormat:@"#%@%@%@",model.category,@" / ",[self timeStrFormTime:model.duration]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DailyDetailViewController *detail = [[DailyDetailViewController alloc]init];
    detail.model = _ListArr[indexPath.row];
    [self presentViewController:detail animated:YES completion:nil];
}


//转换时间格式
-(NSString *)timeStrFormTime:(NSString *)timeStr
{
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
}


@end

//
//  DiscoveryDetailController.m
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "DiscoveryDetailController.h"
#import "VideoListModel.h"
#import "VideoListTableViewCell.h"
#import "DailyDetailViewController.h"

// 类别内时间排序
#define URL @"http://baobab.wandoujia.com/api/v1/videos.bak?strategy=date&categoryName="

@implementation DiscoveryDetailController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *titleStr = [self.pageTitle substringFromIndex:1];
    self.title = titleStr;
    
    [self createNav];
    [self setTopUI];
    self.NextPageStr = [NSString new];
    
    self.ReqId = @"1";
    NSArray *array = [self.actionUrl componentsSeparatedByString:@"title="];
    self.RequestUrl = [NSString stringWithFormat:@"%@%@%@",URL,array.lastObject,@"&num=10"];
    
    [self setTableView];
    
    [self getNetData];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self setupRefresh];
}

- (void)createNav{
    
    self.NavView = [[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.NavView.title = [self.pageTitle substringFromIndex:1];
    self.NavView.color = [UIColor blackColor];
    self.NavView.backTitleImage = @"backImage@2x";
    self.NavView.delegate = self;
    [self.view addSubview:self.NavView];
}

- (void)NavHeadback;{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTopUI{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = [NSArray arrayWithObjects:@"按时间排序",@"分享排行榜", nil];
    for (int i = 0;i < 2;i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(ScreenWidth/2), 5, ScreenWidth/2, 30);
        btn.tag = i;
        [btn setTitle:arr[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [topView addSubview:btn];
        if (i == 0)
        {   btn.selected = YES;
            self.seleBtn = btn;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
        } else {
            btn.selected = NO;
        }
    }
    CGFloat lineWidth = ScreenWidth/4;
    self.line = [[UILabel alloc]initWithFrame:CGRectMake(lineWidth/2,34, lineWidth, 0.5)];
    self.line.backgroundColor = [UIColor grayColor];
    self.line.tag = 100;
    [topView addSubview:self.line];
    
    self.topLine = [[UILabel alloc]initWithFrame:CGRectMake(lineWidth/2, 5, lineWidth, 0.5)];
    self.topLine.backgroundColor = [UIColor grayColor];
    self.topLine.tag = 101;
    [topView addSubview:self.topLine];
    
    [self.view addSubview:topView];
}

- (void)Click:(UIButton*)sender
{
    if (sender.tag == 0) {
        self.ReqId = @"1";
        NSArray *array = [self.actionUrl componentsSeparatedByString:@"title="];
        self.RequestUrl = [NSString stringWithFormat:@"%@%@%@",URL,array.lastObject,@"&num=10"];
        
    }else{
        self.ReqId = @"2";
        self.RequestUrl = [NSString stringWithFormat:@"%@%@%@",ShareTop1,self.idStr,ShareTop2];
    }
    [self getNetData];
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.seleBtn.selected = NO;
    self.seleBtn = sender;
    self.seleBtn.selected = YES;
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint frame = self.line.center;
        frame.x = ScreenWidth/4 + ScreenWidth/2 * (sender.tag);
        self.line.center = frame;
        
        CGPoint frame2 = self.topLine.center;
        frame2.x = ScreenWidth/4 + ScreenWidth/2 * (sender.tag);
        self.topLine.center = frame2;
    }];
}


- (void)setupRefresh{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetData];
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMore];
    }];
    
    self.tableView.mj_footer = footer;
}


- (void)getNetData{
    
    self.ListArr = [[NSMutableArray alloc]init];
    //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"数据加载中..."];

    [Networking requestDataByURL:self.RequestUrl Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([self.ReqId isEqualToString:@"1"]) {
            
            self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
            
            NSDictionary *videoListDict = [responseObject objectForKey:@"videoList"];
            
            for (NSDictionary *dict in videoListDict) {
                
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
            
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            [self endRefresh];
            
        }else{
            
            self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];

            NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
            
            for (NSDictionary *dict in itemListDict) {
                
                NSDictionary *dataDict = dict[@"data"];
                
                VideoListModel *model = [[VideoListModel alloc]init];
                model.ImageView = [NSString stringWithFormat:@"%@",dataDict[@"cover"][@"detail"]];
                model.titleLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
                model.category = [NSString stringWithFormat:@"%@",dataDict[@"category"]];
                model.duration = [NSString stringWithFormat:@"%@",dataDict[@"duration"]];
                model.desc = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
                model.playUrl = [NSString stringWithFormat:@"%@",dataDict[@"playUrl"]];
                NSDictionary *Dic = dataDict[@"consumption"];
                model.consumption = Dic;
                
                [_ListArr addObject:model];
            }
            
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            [self endRefresh];
        }
   
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self endRefresh];
    }];
}

#pragma mark -- 加载更多
- (void)loadMore{

    if ([self.NextPageStr isEqualToString:@"<null>"]) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        
        if ([self.ReqId isEqualToString:@"1"]) {
            
            //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showWithStatus:@"数据加载中..."];
            
            [Networking requestDataByURL:self.NextPageStr Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
                
                NSDictionary *videoListDict = [responseObject objectForKey:@"videoList"];
                
                for (NSDictionary *dict in videoListDict) {
                    
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
                
                [self.tableView reloadData];
                [SVProgressHUD dismiss];
                [self endRefresh];
                
            } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [self endRefresh];
                [SVProgressHUD dismiss];
            }];
            
        }else{
            
            //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showWithStatus:@"数据加载中..."];
            
            [Networking requestDataByURL:self.NextPageStr Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
                
                NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
                
                for (NSDictionary *dict in itemListDict) {
                    
                    NSDictionary *dataDict = dict[@"data"];
                    
                    VideoListModel *model = [[VideoListModel alloc]init];
                    model.ImageView = [NSString stringWithFormat:@"%@",dataDict[@"cover"][@"detail"]];
                    model.titleLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
                    model.category = [NSString stringWithFormat:@"%@",dataDict[@"category"]];
                    model.duration = [NSString stringWithFormat:@"%@",dataDict[@"duration"]];
                    model.desc = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
                    model.playUrl = [NSString stringWithFormat:@"%@",dataDict[@"playUrl"]];
                    NSDictionary *Dic = dataDict[@"consumption"];
                    model.consumption = Dic;
                    
                    [_ListArr addObject:model];
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
}

#pragma mark -- 结束刷新
- (void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark -- 设置TabView
- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104) style:UITableViewStylePlain];
    self.tableView.rowHeight = ScreenHeight/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark -- TableViewDelegate
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

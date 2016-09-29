//
//  DiscoveryDetailController.m
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "DiscoveryDetailController.h"
#import "VideoListModel.h"
#import "VideoListTableViewCell.h"

#define URL @"http://baobab.wandoujia.com/api/v1/videos.bak?strategy=date&categoryName="

#define PopularUrl @"http://baobab.wandoujia.com/api/v3/ranklist?_s=851a7882d2e2de2876f3dde3222637f7"

#define TopUrl @"http://baobab.wandoujia.com/api/v3/specialTopics?_s=44e4ee05b1f5d1efd3e30735e81230b2"

@implementation DiscoveryDetailController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.ListArr = [[NSMutableArray alloc]init];
    self.NextPageStr = [NSString new];
    [self getNetData];
    
    [self setTableView];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self setupRefresh];
    
}

-(void)setupRefresh{
    
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetData];
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMore];
    }];
    
    self.tableView.mj_footer = footer;
}

-(void)getNetData{
    
    NSArray *array = [self.actionUrl componentsSeparatedByString:@"title="];
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@",URL,array.lastObject,@"&num=10"];
    
    [Networking requestDataByURL:str Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.NextPageStr = [responseObject objectForKey:@"nextPageUrl"];
        NSLog(@"NextPageStr == %@",self.NextPageStr);
        
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
        
    }];
}

// 加载更多
-(void)loadMore{
    
    if (self.NextPageStr.length < 30) {
        
        [self endRefresh];
        
    }else{
        
        //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"数据加载中..."];
        
        
        [Networking requestDataByURL:self.NextPageStr Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.NextPageStr = [responseObject objectForKey:@"nextPageUrl"];
            NSLog(@"NextPageStr == %@",self.NextPageStr);
            
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
    }
}


-(void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = ScreenHeight/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    DailyDetailViewController *detail = [[DailyDetailViewController alloc]init];
//    detail.model = _ListArr[indexPath.row];
//    [self presentViewController:detail animated:YES completion:nil];
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

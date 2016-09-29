//
//  ProjectViewController.m
//  App
//
//  Created by CalvinCheung on 16/9/29.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "ProjectViewController.h"
#import "VideoListModel.h"
#import "VideoListTableViewCell.h"

@interface ProjectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *NextPageStr;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *ListArr;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.ListArr = [[NSMutableArray alloc]init];
    self.title = @"专题";
    [self setTableView];
    [self getProjectData];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getProjectData)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self setupRefresh];
    
}

#pragma mark -- 设置TabView
-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = ScreenHeight/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
}

-(void)setupRefresh{
    
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getProjectData];
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMore];
    }];
    
    self.tableView.mj_footer = footer;
}

#pragma mark -- 获取专题
-(void)getProjectData{
    
    //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [Networking requestDataByURL:TopUrl Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        NSLog(@"NextPageStr == %@",self.NextPageStr);

        NSLog(@"responseObject == %@",responseObject);
        
        NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
        
        for (NSDictionary *dict in itemListDict) {
            
            NSDictionary *dataDict = dict[@"data"];
            
            VideoListModel *model = [[VideoListModel alloc]init];
            model.ImageView = [NSString stringWithFormat:@"%@",dataDict[@"image"]];
            model.titleLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
            model.category = [NSString stringWithFormat:@"%@",dataDict[@"dataType"]];
            model.desc = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
            model.actionUrl = [NSString stringWithFormat:@"%@",dataDict[@"actionUrl"]];
            [_ListArr addObject:model];
        }
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self endRefresh];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- 加载更多
-(void)loadMore{
    
    if ([self.NextPageStr isEqualToString:@"<null>"]) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{

        //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"数据加载中..."];
        
        [Networking requestDataByURL:self.NextPageStr Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
            NSLog(@"NextPageStr == %@",self.NextPageStr);
            
            NSLog(@"responseObject == %@",responseObject);
            
            NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
            
            for (NSDictionary *dict in itemListDict) {
                
                NSDictionary *dataDict = dict[@"data"];
                
                VideoListModel *model = [[VideoListModel alloc]init];
                model.ImageView = [NSString stringWithFormat:@"%@",dataDict[@"image"]];
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

#pragma mark -- 结束刷新
-(void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark -- TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ListArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ScreenHeight/3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IDStr = @"cell";
    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDStr];
    if (!cell) {
        cell = [[VideoListTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:IDStr];
    }
    
    VideoListModel *model = _ListArr[indexPath.row];
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageView]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    DailyDetailViewController *detail = [[DailyDetailViewController alloc]init];
    //    detail.model = _ListArr[indexPath.row];
    //    [self presentViewController:detail animated:YES completion:nil];
}

@end

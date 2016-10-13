//
//  ProjectNextViewController.m
//  App
//
//  Created by CalvinCheung on 16/10/2.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "ProjectNextViewController.h"
#import "VideoListTableViewCell.h"
#import "DailyDetailViewController.h"

@interface ProjectNextViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString *nextPageUrl;

@property (nonatomic, strong) NSMutableArray *ListArr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ProjectNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont fontWithName:MyChinFont size:16.f],
       
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    NSString *str = [self.model.actionUrl componentsSeparatedByString:@"title="].lastObject;
    self.title = [[str componentsSeparatedByString:@"&url="].firstObject stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
    [self getNetData];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self setupRefresh];
}

#pragma mark -- 设置TabView
- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = ScreenHeight/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
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

- (void)getNetData{
    
    //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    self.ListArr = [[NSMutableArray alloc]init];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",ZhuanTi1,self.model.idStr,ZhuanTi2];
    [Networking requestDataByURL:urlStr Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.nextPageUrl = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
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
        
        NSLog(@"error == %@",error.description);
        [self endRefresh];
        [SVProgressHUD dismiss];
    }];
    
}

- (void)loadMore{
    
    if ([self.nextPageUrl isEqualToString:@"<null>"]) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        
        //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"数据加载中..."];
        
        [Networking requestDataByURL:self.nextPageUrl Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.nextPageUrl = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
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
            
            NSLog(@"error == %@",error.description);
            [self endRefresh];
            [SVProgressHUD dismiss];
        }];
    }
}

#pragma mark -- 结束刷新
- (void)endRefresh{
    
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

//
//  ThreeViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "ThreeViewController.h"
#import "MyHelper.h"
#import "AuthorTableViewCell.h"
#import "AuthorModel.h"

@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *TableView;
// 网络请求
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) NSDictionary *Dict;

@property (nonatomic, strong) NSString *nextPageUrl;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nextPageUrl = [NSString new];
    
    [self setNavi];
    
    [self getNetData];
    
    //默认【下拉刷新】
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    //默认【上拉加载】
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self setTableView];
    [self setupRefresh];
    
    
}

-(void)setupRefresh{
    
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetData];
    }];
    
    self.TableView.mj_header = header;
    
    [header setTitle:@"刷新完成" forState:MJRefreshStateIdle];
    [header setTitle:@"下拉刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.font = [UIFont systemFontOfSize:20];
    
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    MJRefreshAutoNormalFooter *footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMore];
    }];
    
    self.TableView.mj_footer = footer;
}

-(void)setNavi{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFont size:30];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}


-(void)getNetData{
    
    //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    self.modelArr = [[NSMutableArray alloc]init];
    
    [Networking requestDataByURL:Author Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *itemListArr = [responseObject objectForKey:@"itemList"];
        
        self.nextPageUrl = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        NSLog(@"nextPageUrl1 == %@",self.nextPageUrl);
        
        for (NSDictionary *dict in itemListArr) {
            NSDictionary *dataDict = dict[@"data"];
            
            AuthorModel *model = [[AuthorModel alloc]init];
            model.iconImage = [NSString stringWithFormat:@"%@",dataDict[@"icon"]];
            model.authorLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
            model.videoCount = [NSString stringWithFormat:@"%@",dataDict[@"subTitle"]];
            model.desLabel = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
            
            [_modelArr addObject:model];
        }
        [self.TableView reloadData];
        [self endRefresh];
        [SVProgressHUD dismiss];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self endRefresh];
        [SVProgressHUD dismiss];
    }];
}

-(void)endRefresh{
    
    [self.TableView.mj_header endRefreshing];
    [self.TableView.mj_footer endRefreshing];
}

-(void)loadMore{
    
    if ([self.nextPageUrl isEqualToString:@"<null>"]) {
        
        [self endRefresh];
        
    }else{
        
        //正方形的背景样式(或颜色),黑色背景,白色圆环和文字
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"数据加载中..."];
        
        [Networking requestDataByURL:self.nextPageUrl Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.nextPageUrl = nil;
            NSArray *itemListArr = [responseObject objectForKey:@"itemList"];
            
            self.nextPageUrl = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
            NSLog(@"nextPageUrl2 == %@",self.nextPageUrl);
            
            for (NSDictionary *dict in itemListArr) {
                NSDictionary *dataDict = dict[@"data"];
                
                AuthorModel *model = [[AuthorModel alloc]init];
                model.iconImage = [NSString stringWithFormat:@"%@",dataDict[@"icon"]];
                model.authorLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
                model.videoCount = [NSString stringWithFormat:@"%@",dataDict[@"subTitle"]];
                model.desLabel = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
                
                [_modelArr addObject:model];
            }
            
            [self.TableView reloadData];
            [self endRefresh];
            [SVProgressHUD dismiss];
            
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self endRefresh];
            [SVProgressHUD dismiss];
        }];
    }
}

-(void)setTableView{
    
    _TableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _TableView.delegate =self;
    _TableView.dataSource = self;
    _TableView.rowHeight = 60;
    [self.view addSubview:_TableView];
}


#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *iDs = @"cell";
    AuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iDs];
    if (!cell) {
        
        cell = [[AuthorTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iDs];
    }
    AuthorModel *model = _modelArr[indexPath.row];
    cell.authorLabel.text = model.authorLabel;
    cell.videoCount.text = model.videoCount;
    cell.desLabel.text = model.desLabel;
    
    return cell;
}

/**
 *  这里最主要的代码,通过滑动,改变透明度
 *
 *  @param scrollView scrollView description
 */
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    self.navigationController.navigationBar.alpha = scrollView.contentOffset.y/200;
//}

@end

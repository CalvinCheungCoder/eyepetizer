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

@property (nonatomic, strong) NSMutableArray *ListArr;

@property (nonatomic, strong) NSMutableArray *modelArr;

/** 所有的团购数据 */
@property (nonatomic, strong) NSDictionary *Dict;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _ListArr = [[NSMutableArray alloc]init];
    _modelArr = [[NSMutableArray alloc]init];
    
    [self setNavi];
    [self setTableView];
    [self getNetData];
}

-(void)setNavi{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFont size:30];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

-(void)setTableView{
    
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _TableView.delegate =self;
    _TableView.dataSource = self;
    _TableView.rowHeight = 60;
    [self.view addSubview:_TableView];
}

-(void)getNetData{
    
    _manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];

    [_manager GET:Author parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *itemList = [responseObject objectForKey:@"itemList"];
        
        for (NSDictionary *dict in itemList) {
            NSString *type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"briefCard"]) {
                NSDictionary *dataDict = dict[@"data"];
                [_ListArr addObject:dataDict];
            }
        }
        NSLog(@"_modelArr = %@",_modelArr);
        
        [self.TableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _ListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *iDs = @"cell";
    AuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iDs];
    if (!cell) {
        
        cell = [[AuthorTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iDs];
    }
    NSDictionary *dict = _ListArr[indexPath.row];
    NSString *iconStr = dict[@"icon"];
    NSString *author = dict[@"title"];
    NSString *videoStr = dict[@"subTitle"];
    NSString *des = dict[@"description"];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:iconStr] completed:nil];
    cell.authorLabel.text = author;
    cell.videoCount.text = videoStr;
    cell.desLabel.text = des;
    
    NSLog(@"%@",author);
    NSLog(@"%@",des);
    
    return cell;
}

/**
 *  这里最主要的代码,通过滑动,改变透明度
 *
 *  @param scrollView scrollView description
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.navigationController.navigationBar.alpha = scrollView.contentOffset.y/200;
}

@end

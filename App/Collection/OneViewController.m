//
//  OneViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "OneViewController.h"
#import "MyHelper.h"
#import "VideoListTableViewCell.h"
#import "DailyDetailViewController.h"

#define dailyList @"http://baobab.wandoujia.com/api/v1/feed.bak?num=%d&date=%@"

@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
// 网络请求
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property (nonatomic, strong) NSMutableArray *ListArr;

@property (nonatomic, strong) NSString *NextPageStr;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RandomColor;
    

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFont size:30];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    _ListArr = [[NSMutableArray alloc]init];
    // 设置TableView
    [self setTableView];
    // 获取网络数据
    [self getNetData];
}

-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.rowHeight = ScreenHeight/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
}

-(void)getNetData{
    
    _manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *str = [self changeTime:[self getdate]];
    NSString *urlStr = [NSString stringWithFormat:dailyList,10,str];
    NSLog(@"urlStr = %@",urlStr);
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];//正方形的背景样式(或颜色),黑色背景,白色圆环和文字
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [_manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.NextPageStr = [responseObject objectForKey:@"nextPageUrl"];
        NSString *nextPublishTime = [responseObject objectForKey:@"nextPublishTime"];
        
        NSDictionary *dailyListDict = [responseObject objectForKey:@"dailyList"];
        
        for (NSDictionary *videoList in dailyListDict) {
            NSArray *temp = [videoList objectForKey:@"videoList"];
            
            for (NSDictionary *dict in temp) {
                
                [_ListArr addObject:dict];
            }
        }
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
    
    NSDictionary *dict = _ListArr[indexPath.row];
    NSString *coverForDetail = dict[@"coverForDetail"];
    NSString *duration = dict[@"duration"];
    NSString *title = dict[@"title"];
    NSString *category = dict[@"category"];
    
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:coverForDetail] completed:nil];
    cell.titleLabel.text = title;
    cell.messageLabel.text = [NSString stringWithFormat:@"#%@%@%@",category,@" / ",[self timeStrFormTime:duration]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DailyDetailViewController *detail = [[DailyDetailViewController alloc]init];
    detail.dataDict = _ListArr[indexPath.row];
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

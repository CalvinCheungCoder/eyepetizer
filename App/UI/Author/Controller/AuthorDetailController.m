//
//  AuthorDetailController.m
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "AuthorDetailController.h"

@interface AuthorDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation AuthorDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableView];
}

-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    [self.view addSubview:self.tableView];
}


//#pragma mark -- TableView
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return _modelArr.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *iDs = @"cell";
//    AuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iDs];
//    if (!cell) {
//        
//        cell = [[AuthorTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iDs];
//    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    AuthorModel *model = _modelArr[indexPath.row];
//    cell.authorLabel.text = model.authorLabel;
//    cell.videoCount.text = model.videoCount;
//    cell.desLabel.text = model.desLabel;
//    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconImage]];
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    AuthorDetailController *detail = [[AuthorDetailController alloc]init];
//    AuthorModel *model = _modelArr[indexPath.row];
//    detail.authorId = model.authorId;
//    detail.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detail animated:YES];
//}

/**
 *  这里最主要的代码,通过滑动,改变透明度
 *
 *  @param scrollView scrollView description
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    self.navigationController.navigationBar.alpha = scrollView.contentOffset.y/200;
}

@end

//
//  FourViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "FourViewController.h"


@interface FourViewController ()

@end

@implementation FourViewController

//- (UITableView *)tableView{
//    
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, ScreenHeight - 244) style:UITableViewStyleGrouped];
//        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.showsVerticalScrollIndicator = NO;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
//    }
//    return _tableView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//#pragma mark -- TableViewDeletage & Datasouth
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return 2;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return 4;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    _listArr = [NSArray arrayWithObjects:@"相册",@"收藏",@"钱包",@"卡包", nil];
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"forIndexPath:indexPath];
//    
//    cell.textLabel.text = _listArr[indexPath.row];
//    
//    return cell;
//}


@end

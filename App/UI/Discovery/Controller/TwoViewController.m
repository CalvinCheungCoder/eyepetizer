//
//  TwoViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "TwoViewController.h"
#import "UIImageView+WebCache.h"
#import "DiscoveryCell.h"
#import "DiscoveryDetailController.h"
#import "DiscoveryModel.h"
#import "PopularViewController.h"
#import "ProjectViewController.h"

@interface TwoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *ListArr;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    // 流水布局:调整cell尺寸
    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
    
    // 创建UICollectionView
    [self setupCollectionView:layout];
    
    // 获取网络数据
    [self getNetData];
}

#pragma mark - 创建流水布局
- (UICollectionViewFlowLayout *)setupCollectionViewFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (ScreenWidth - 9)/2;
    layout.itemSize = CGSizeMake(width, width);
    layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置最小行间距
    layout.minimumLineSpacing = 3;
    // 设置最小列间距
    layout.minimumInteritemSpacing = 1.5;
    
    return layout;
}

#pragma mark - 创建UICollectionView
- (void)setupCollectionView:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.backgroundColor = [UIColor whiteColor];
    collection.center = self.view.center;
    collection.bounds = self.view.bounds;
    collection.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collection];
    
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[DiscoveryCell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView = collection;
}

- (void)getNetData{
    
    _ListArr = [[NSMutableArray alloc]init];
    
    NSString *urlStr = @"http://baobab.wandoujia.com/api/v3/discovery";
    [Networking requestDataByURL:urlStr Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *itemList = [responseObject objectForKey:@"itemList"];
        for (NSDictionary *dict in itemList) {
            NSString *type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"squareCard"]) {
                
                NSDictionary *dataDic = dict[@"data"];
                NSMutableArray *arr = [[NSMutableArray alloc]init];
                [arr addObject:dataDic];
                
                for (NSDictionary *Dic in arr) {
                    
                    DiscoveryModel *model = [[DiscoveryModel alloc]init];
                    model.image = [NSString stringWithFormat:@"%@",Dic[@"image"]];
                    model.actionUrl = [NSString stringWithFormat:@"%@",Dic[@"actionUrl"]];
                    model.title = [NSString stringWithFormat:@"%@",Dic[@"title"]];
                    model.IdStr = [NSString stringWithFormat:@"%@",Dic[@"id"]];
                    [_ListArr addObject:model];
                }
            }
        }
        [_collectionView reloadData];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _ListArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DiscoveryCell *cell = (DiscoveryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    DiscoveryModel *model = _ListArr[indexPath.row];
    
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    cell.titleLabel.text = model.title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        PopularViewController *popular = [[PopularViewController alloc]init];
        popular.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:popular animated:YES];
        
    }else if (indexPath.row == 1){
        
        ProjectViewController *project = [[ProjectViewController alloc]init];
        project.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:project animated:YES];
        
    }else{
    
        DiscoveryDetailController *dis = [[DiscoveryDetailController alloc]init];
        DiscoveryModel *model = _ListArr[indexPath.row];
        dis.actionUrl = model.actionUrl;
        dis.pageTitle = model.title;
        dis.idStr = model.IdStr;
        dis.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:dis animated:YES];
    }
}

#pragma mark - layout的代理事件
- (CGFloat)puBuLiuLayoutHeightForItemAtIndex:(NSIndexPath *)index {
    
    return ScreenHeight/4;
}



@end

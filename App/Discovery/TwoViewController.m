//
//  TwoViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/5.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "TwoViewController.h"
#import "MyHelper.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "DiscoveryCell.h"

@interface TwoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

// 网络请求
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property (nonatomic, strong) NSMutableArray *ListArr;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFont size:30];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _ListArr = [[NSMutableArray alloc]init];
    
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
    [collection registerClass:[DiscoveryCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView = collection;
}

-(void)getNetData{
    
    _manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlStr = @"http://baobab.wandoujia.com/api/v3/discovery";
    [_manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *itemList = [responseObject objectForKey:@"itemList"];
        for (NSDictionary *dict in itemList) {
            NSString *type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"squareCard"]) {
                [_ListArr addObject:dict];
            }
        }
        NSLog(@"_ListArr = %@",_ListArr);
        
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
        
    DiscoveryCell *cell = (DiscoveryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dict = _ListArr[indexPath.row];
    NSDictionary *dict2 = [dict objectForKey:@"data"];
    NSString *imageStr = [dict2 objectForKey:@"image"];
    NSString *titleStr = [dict2 objectForKey:@"title"];
    
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    cell.titleLabel.text = titleStr;
    return cell;
}

#pragma mark - layout的代理事件
- (CGFloat)puBuLiuLayoutHeightForItemAtIndex:(NSIndexPath *)index {
    
    return ScreenHeight/4;
}



@end

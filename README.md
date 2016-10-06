# eyepetizer 高仿每日开眼App

## 实现的主要功能与说明

* 全部页面均使用纯代码实现，也是因为公司项目一般都是纯代码，所以没有使用 storyboard

* 自定义 NavigationController，实现页面整体侧滑，侧滑时不隐藏 Navigation（个人比较喜欢这样的风格）

* 使用自定义字体设置为 NavigationBar title

* 自定义分享视图

* 作者详情页面自定义 Nav

* 利用 Button 实现了类似 UISegment 的视图切换效果

* 自定义视频播放界面，使用 AVPlayer 实现视频播放

『实现效果』：

![image](https://github.com/CalvinCheungCoder/eyepetizer/blob/master/Views.gif)


### 作者详情页面

1、主要代码：

 ``` Objective-C
 
 // 头视图
-(void)setHeadView{
    
    _headImageView = [[HeadView alloc]init];
    _headImageView.frame = CGRectMake(0, 64, ScreenWidth, 170);
    _headImageView.backgroundColor = [UIColor whiteColor];
    
    [_headImageView.imageView sd_setImageWithURL:[NSURL URLWithString:self.authorIcon]];
    _headImageView.NameLab.text = self.authorName;
    _headImageView.contentLab.text = self.authorDesc;
    [self.view addSubview:_headImageView];
}

-(void)createNav{
    
    self.NavView = [[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.NavView.title = @"";
    self.NavView.color = [UIColor whiteColor];
    self.NavView.backTitleImage = @"backImage@2x";
    self.NavView.rightTitleImage = @"icon_share_n@2x";
    self.NavView.delegate = self;
    [self.view addSubview:self.NavView];
}

#pragma mark -- 移动变色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsety = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y <= 170) {
        self.NavView.headBgView.alpha = scrollView.contentOffset.y/170;
        self.NavView.backTitleImage = @"backImage@2x";
        self.NavView.rightImageView = @"icon_share_n@2x";
        self.NavView.color = [UIColor whiteColor];
        // 状态栏字体白色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else{
        self.NavView.headBgView.alpha = 1;
        self.NavView.title = self.authorName;
        self.NavView.backTitleImage = @"backImage@2x";
        self.NavView.rightImageView = @"icon_share_n@2x";
        self.NavView.color = [UIColor blackColor];
        // 隐藏黑线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        // 状态栏字体黑色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    }
    
    if (contentOffsety < 0) {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight-contentOffsety;
        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else{
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backgroundImgV.frame = rect;
    }
}
 ``` 
 
 2、『实现效果』：
 
 ![](https://github.com/CalvinCheungCoder/eyepetizer/blob/master/AuthorDetail.gif)


### 自定义分享视图
 
 1、使用代码
 
  ``` Objective-C
 
 // 右按钮回调
-(void)NavHeadToRight{
    
    NSArray *shareAry = @[@{@"image":@"shareView_wx@2x",
                            @"title":@"微信"},
                          @{@"image":@"shareView_friend@2x",
                            @"title":@"朋友圈"},
                          @{@"image":@"shareView_qq@2x",
                            @"title":@"QQ"},
                          @{@"image":@"shareView_wb@2x",
                            @"title":@"新浪微博"},
                          @{@"image":@"shareView_qzone@2x",
                            @"title":@"QQ空间"},
                          @{@"image":@"share_copyLink",
                            @"title":@"复制链接"}];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:MyChinFont size:16.f];
    label.text = @"分享";
    [headerView addSubview:label];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, headerView.frame.size.height-0.5, headerView.frame.size.width - 40, 0.5)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [headerView addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, headerView.frame.size.width - 40, 0.5)];
    lineLabel1.backgroundColor = [UIColor blackColor];
    
    ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:7];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.middleLineLabel.hidden = YES;
    [shareView.cancleButton addSubview:lineLabel1];
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [shareView.cancleButton setTitleColor:[UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
    [shareView setShareAry:shareAry delegate:self];
    [self.navigationController.view addSubview:shareView];
}
 
 ``` 
 
 2、『实现效果』：
 
 ![](https://github.com/CalvinCheungCoder/eyepetizer/blob/master/Share.gif)


### 自定义NavigationController

『实现效果』：

![](https://github.com/CalvinCheungCoder/eyepetizer/blob/master/CustomerNav.gif)


### 视频播放

『实现效果』：

![](https://github.com/CalvinCheungCoder/eyepetizer/blob/master/Play.gif)


### 使用到的第三方库

* [AFNetworking](https://github.com/AFNetworking/AFNetworking)

* [MJRefresh](https://github.com/CoderMJLee/MJRefresh)

* [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD)

* [SDWebImage](https://github.com/rs/SDWebImage)

* [HXEasyCustomShareView](https://github.com/huangxuan518/HXEasyCustomShareView)


### 运行环境

Xcode Version 8.0 (8A218a)

Simulator iPhone SE - iOS 10.0


### 最后说明

1、本次分享旨在学习与交流，如果涉及版权问题会及时删除代码.

2、如果大家喜欢请给 Star.

3、首页和作者列表页面只使用了一个 UITableView 实现主要功能，主要是界面复杂懒得写了.

4、个人博客地址：[Calvin | Stay Hungry. Stay Foolish.](http://www.zhangdinghao.cn).


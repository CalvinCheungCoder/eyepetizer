//
//  ShareView.h
//  CustomToShare
//
//  Created by 张丁豪 on 16/9/17.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShareView;

@protocol CustomShareViewDelegate <NSObject>

- (void)easyCustomShareViewButtonAction:(ShareView *)shareView title:(NSString *)title;

@end

@interface ShareView : UIView

@property (nonatomic,assign) id<CustomShareViewDelegate> delegate;
// 背景View
@property (nonatomic,strong) UIView *backView;
// 头部分享标题
@property (nonatomic,strong) UIView *headerView;
// 中间View,主要放分享
@property (nonatomic,strong) UIView *boderView;
// 中间分隔线
@property (nonatomic,strong) UILabel *middleLineLabel;
// 第一行分享媒介数量,分享媒介最多显示2行,如果第一行显示了全部则不显示第二行
@property (nonatomic,assign) NSInteger firstCount;
// 尾部其他自定义View
@property (nonatomic,strong) UIView *footerView;
// 取消
@property (nonatomic,strong) UIButton *cancleButton;
// 是否显示滚动条
@property (nonatomic,assign) BOOL showsHorizontalScrollIndicator;

- (void)setShareAry:(NSArray *)shareAry delegate:(id)delegate;

- (float)getBoderViewHeight:(NSArray *)shareAry firstCount:(NSInteger)count;

@end

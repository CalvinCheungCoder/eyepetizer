//
//  NavHeadTitleView.h
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import <UIKit/UIKit.h>

@protocol NavHeadTitleViewDelegate <NSObject>

@optional

- (void)NavHeadback;
- (void)NavHeadToRight;

@end

@interface NavHeadTitleView : UIView

@property (nonatomic, assign) id<NavHeadTitleViewDelegate>delegate;

@property (nonatomic, strong) UIImageView *headBgView;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, copy) NSString *backTitleImage;

@property (nonatomic, copy) NSString *rightImageView;

@property (nonatomic, copy) NSString *rightTitleImage;

@end

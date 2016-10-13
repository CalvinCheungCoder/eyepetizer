//
//  NavHeadTitleView.m
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "NavHeadTitleView.h"

@interface NavHeadTitleView()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIButton *back;

@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation NavHeadTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.headBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.headBgView.backgroundColor = [UIColor whiteColor];
        //隐藏黑线
        self.headBgView.alpha = 0;
        [self addSubview:self.headBgView];
        
        self.back = [UIButton buttonWithType:UIButtonTypeCustom];
        self.back.backgroundColor = [UIColor clearColor];
        self.back.frame = CGRectMake(5, 30, 20, 20);
        [self.back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.back];
        
        self.backgroundColor = [UIColor clearColor];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, frame.size.width-80, 30)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont fontWithName:MyChinFont size:16.f];
        [self addSubview:self.label];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.backgroundColor = [UIColor clearColor];
        self.rightBtn.frame = CGRectMake(self.frame.size.width-45, 30, 20, 20);
        [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBtn];
        
    }
    return self;
}

- (void)setBackTitleImage:(NSString *)backTitleImage
{
    _backTitleImage = backTitleImage;
    [self.back setImage:[UIImage imageNamed:_backTitleImage] forState:UIControlStateNormal];
}

- (void)setRightImageView:(NSString *)rightImageView
{
    _rightImageView = rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
}

- (void)setRightTitleImage:(NSString *)rightImageView
{
    _rightImageView = rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.label.text = title;
}

- (void)setColor:(UIColor *)color{
    _color = color;
    self.label.textColor = color;
}

// 返回按钮
- (void)backClick{
    if ([_delegate respondsToSelector:@selector(NavHeadback)] ) {
        [_delegate NavHeadback];
    }
}

// 右边按钮
- (void)rightBtnClick{
    if ([_delegate respondsToSelector:@selector(NavHeadToRight)]) {
        [_delegate NavHeadToRight];
    }
}

- (void)jianBian{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.label.frame;
    gradientLayer.colors = @[(id)[UIColor colorWithRed:222/225.0 green:98/255.0 blue:26/255.0 alpha:0.1].CGColor, (id)[UIColor colorWithRed:245/225.0 green:163/255.0 blue:17/255.0 alpha:1].CGColor];
    gradientLayer.mask = self.label.layer;
    [self.layer addSublayer:gradientLayer];
    self.label.frame = gradientLayer.bounds;
}

@end

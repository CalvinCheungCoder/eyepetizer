//
//  PopularCell.m
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "PopularCell.h"

@implementation PopularCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.ImageView = image;
        
        UIImageView *shadeView = [[UIImageView alloc]init];
        shadeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.shadeView = shadeView;
        [image addSubview:self.shadeView];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont fontWithName:MyChinFont size:14.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont systemFontOfSize:12.f];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:messageLabel];
        self.messageLabel = messageLabel;
        
        UILabel *index = [[UILabel alloc] init];
        index.textColor = [UIColor whiteColor];
        index.font = [UIFont fontWithName:MyEnFontTwo size:12];
        index.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:index];
        self.indexLabel = index;
        
        UIButton *top = [[UIButton alloc]init];
        top.backgroundColor = [UIColor whiteColor];
        top.userInteractionEnabled = NO;
        [self.contentView addSubview:top];
        self.topLine = top;
        
        UIButton *bottom = [[UIButton alloc]init];
        bottom.backgroundColor = [UIColor whiteColor];
        bottom.userInteractionEnabled = NO;
        [self.contentView addSubview:bottom];
        self.bottomLine = bottom;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.ImageView.frame = self.bounds;
    
    self.shadeView.frame = self.bounds;
    
    /** 标题 */
    self.titleLabel.frame = CGRectMake(5, self.bounds.size.height/2 - 10, self.bounds.size.width - 10, 20);
    
    /** 信息 */
    self.messageLabel.frame = CGRectMake(0, _titleLabel.bottom, _titleLabel.width, 25);
    
    self.topLine.frame = CGRectMake(ScreenWidth/2 - 15, _messageLabel.bottom + 20, 30, 0.5);
    
    self.indexLabel.frame = CGRectMake(ScreenWidth/2 - 30, _topLine.bottom + 5, 60, 15);
    
    self.bottomLine.frame = CGRectMake(ScreenWidth/2 - 15, _indexLabel.bottom + 3, 30, 0.5);
}
@end

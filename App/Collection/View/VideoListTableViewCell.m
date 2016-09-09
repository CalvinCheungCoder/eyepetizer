//
//  VideoListTableViewCell.m
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "VideoListTableViewCell.h"

@implementation VideoListTableViewCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /** 图片 */
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.ImageView = image;
        
        UIImageView *shadeView = [[UIImageView alloc]init];
        shadeView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        self.shadeView = shadeView;
        [image addSubview:self.shadeView];
        
        /** 标题 */
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont fontWithName:MyChinFont size:16.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        /** 价格 */
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont systemFontOfSize:12.f];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:messageLabel];
        self.messageLabel = messageLabel;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    /** 图标 */
    self.ImageView.frame = self.bounds;
    
    self.shadeView.frame = self.bounds;
    
    /** 标题 */
    self.titleLabel.frame = CGRectMake(0, self.bounds.size.height/2 - 20, self.bounds.size.width, 30);
    
    /** 信息 */
    self.messageLabel.frame = CGRectMake(0, _titleLabel.bottom, _titleLabel.width, 25);
}

@end

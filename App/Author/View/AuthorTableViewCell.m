//
//  AuthorTableViewCell.m
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "AuthorTableViewCell.h"

@implementation AuthorTableViewCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.iconImage = image;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont fontWithName:MyChinFont size:14.f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        self.authorLabel = titleLabel;
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = [UIColor grayColor];
        messageLabel.font = [UIFont systemFontOfSize:12.f];
        messageLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:messageLabel];
        self.videoCount = messageLabel;
        
        UILabel *desLabel = [[UILabel alloc]init];
        desLabel.textColor = [UIColor blackColor];
        desLabel.font = [UIFont systemFontOfSize:12.f];
        desLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:desLabel];
        self.desLabel = desLabel;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.authorLabel.frame = CGRectMake(20, 10, 100, 20);
    
    self.videoCount.frame = CGRectMake(self.authorLabel.right + 5, 10, 70, 20);
    
    self.desLabel.frame = CGRectMake(_authorLabel.left,_authorLabel.bottom + 5, ScreenWidth - 50, 20);
}


@end

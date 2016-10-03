//
//  DiscoveryCell.h
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import <UIKit/UIKit.h>

@interface DiscoveryCell : UICollectionViewCell

/** 图片 */
@property (nonatomic, strong) UIImageView *ImageView;

@property (nonatomic, strong) UIImageView *shadeView;

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

@end

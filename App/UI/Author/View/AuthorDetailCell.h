//
//  AuthorDetailCell.h
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorDetailCell : UITableViewCell

/** 图片 */
@property (nonatomic, weak) UIImageView *ImageView;

@property (nonatomic, weak) UIImageView *shadeView;

/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/** Message */
@property (nonatomic, weak) UILabel *messageLabel;

@end

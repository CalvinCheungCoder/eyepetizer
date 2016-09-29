//
//  DiscoveryCell.h
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoveryCell : UICollectionViewCell

/** 图片 */
@property (nonatomic, strong) UIImageView *ImageView;

@property (nonatomic, strong) UIImageView *shadeView;

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

@end


//
//  Created by 张丁豪 on 15/7/29.
//  Copyright (c) 2015年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

@property (nonatomic, assign) CGFloat sd_height;
@property (nonatomic, assign) CGFloat sd_width;

@property (nonatomic, assign) CGFloat sd_y;
@property (nonatomic, assign) CGFloat sd_x;



//宽
- (CGFloat)width;

//高
- (CGFloat)height;

//上
- (CGFloat)top;

//下
- (CGFloat)bottom;

//左
- (CGFloat)left;

//右
- (CGFloat)right;

//设置宽
- (void)setWidth:(CGFloat)width;

//设置高
- (void)setHeight:(CGFloat)height;

//设置x
- (void)setXOffset:(CGFloat)x;

//设置y
- (void)setYOffset:(CGFloat)y;


@end

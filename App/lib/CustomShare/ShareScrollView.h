//
//  ShareScrollView.h
//  CustomToShare
//
//  Created by 张丁豪 on 16/9/17.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

// icon起点X坐标
#define OriginX 15.0
// icon起点Y坐标
#define OriginY 15.0
// 正方形图标宽度
#define IconWidth 57.0
// 图标和标题间的间隔
#define IconAndTitleSpace 10.0
// 标签字体大小
#define TitleSize 10.0
// 标签字体颜色
#define TitleColor [UIColor colorWithRed:52/255.0 green:52/255.0 blue:50/255.0 alpha:1.0]
// 尾部间隔
#define LastlySpace 15.0
// 横向间距
#define HorizontalSpace 15.0

@class ShareScrollView;

@protocol ShareScrollViewDelegate <NSObject>

- (void)shareScrollViewButtonAction:(ShareScrollView *)shareScrollView title:(NSString *)title;

@end

@interface ShareScrollView : UIScrollView

@property (nonatomic,assign) id<ShareScrollViewDelegate> MyScrollViewDelegate;
// icon起点X坐标
@property (nonatomic,assign) float originX;
// icon起点Y坐标
@property (nonatomic,assign) float originY;
// 正方形图标宽度
@property (nonatomic,assign) float icoWidth;
// 图标和标题间的间隔
@property (nonatomic,assign) float icoAndTitleSpace;
// 标签字体大小
@property (nonatomic,assign) float titleSize;
// 标签字体颜色
@property (nonatomic,strong) UIColor *titleColor;
// 尾部间隔
@property (nonatomic,assign) float lastlySpace;
// 横向间距
@property (nonatomic,assign) float horizontalSpace;

- (void)setShareAry:(NSArray *)shareAry delegate:(id)delegate;

+ (float)getShareScrollViewHeight;

@end

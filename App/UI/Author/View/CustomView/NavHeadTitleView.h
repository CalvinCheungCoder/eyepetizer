//
//  NavHeadTitleView.h
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavHeadTitleViewDelegate <NSObject>

@optional

- (void)NavHeadback;
- (void)NavHeadToRight;

@end

@interface NavHeadTitleView : UIView

@property (nonatomic, assign) id<NavHeadTitleViewDelegate>delegate;

@property (nonatomic, strong) UIImageView *headBgView;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) NSString *backTitleImage;

@property (nonatomic, strong) NSString *rightImageView;

@property (nonatomic, strong) NSString *rightTitleImage;

@end

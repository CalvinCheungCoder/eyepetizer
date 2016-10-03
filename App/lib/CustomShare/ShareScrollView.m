//
//  ShareScrollView.m
//  CustomToShare
//
//  Created by 张丁豪 on 16/9/17.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "ShareScrollView.h"

@implementation ShareScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        self.backgroundColor = [UIColor clearColor];
        
        _originX = OriginX;
        _originY = OriginY;
        _icoWidth = IconWidth;
        _icoAndTitleSpace = IconAndTitleSpace;
        _titleSize = TitleSize;
        _titleColor = TitleColor;
        _lastlySpace = LastlySpace;
        _horizontalSpace = HorizontalSpace;
        
        // 设置当前scrollView的高度
        if (self.frame.size.height <= 0) {
            self.frame = CGRectMake(CGRectGetMinX([self frame]), CGRectGetMinY([self frame]), CGRectGetWidth([self frame]), _originY+_icoWidth+_icoAndTitleSpace+_titleSize+_lastlySpace);
        } else {
            self.frame = frame;
        }
    }
    return self;
}

- (void)setShareAry:(NSArray *)shareAry delegate:(id)delegate {
    
    // 先移除之前的View
    if (self.subviews.count > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    // 代理
    _MyScrollViewDelegate = delegate;
    
    // 设置当前scrollView的contentSize
    if (shareAry.count > 0) {
        // 单行
        self.contentSize = CGSizeMake(_originX+shareAry.count*(_icoWidth+_horizontalSpace),self.frame.size.height);
    }
    
    // 遍历标签数组,将标签显示在界面上,并给每个标签打上tag加以区分
    for (NSDictionary *shareDic in shareAry) {
        
        NSUInteger i = [shareAry indexOfObject:shareDic];
        
        CGRect frame = CGRectMake(_originX+i*(_icoWidth+_horizontalSpace), _originY, _icoWidth, _icoWidth+_icoAndTitleSpace+_titleSize);;
        UIView *view = [self ittemShareViewWithFrame:frame dic:shareDic];
        [self addSubview:view];
    }
}

- (UIView *)ittemShareViewWithFrame:(CGRect)frame dic:(NSDictionary *)dic {
    
    NSString *image = dic[@"image"];
    NSString *highlightedImage = dic[@"highlightedImage"];
    NSString *title = [dic[@"title"] length] > 0 ? dic[@"title"] : @"";
    
    UIImage *icoImage = [UIImage imageNamed:image];
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((view.frame.size.width-icoImage.size.width)/2, 0, icoImage.size.width, icoImage.size.height);
    button.titleLabel.font = [UIFont systemFontOfSize:_titleSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    if (image.length > 0) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highlightedImage.length > 0) {
        [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    }
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.frame.origin.y +button.frame.size.height+ _lastlySpace, view.frame.size.width, _titleSize)];
    label.textColor = _titleColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:_titleSize];
    label.text = title;
    [view addSubview:label];
    
    return view;
}


+ (float)getShareScrollViewHeight {
    float height = OriginY + IconWidth + IconAndTitleSpace + TitleSize + LastlySpace;
    return height;
}

- (void)buttonAction:(UIButton *)sender {
    if (_MyScrollViewDelegate && [_MyScrollViewDelegate respondsToSelector:@selector(shareScrollViewButtonAction:title:)]) {
        [_MyScrollViewDelegate shareScrollViewButtonAction:self title:sender.titleLabel.text];
    }
}


@end

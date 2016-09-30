//
//  HeadView.h
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView

@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *NameLab;

@property (nonatomic, strong) UILabel *contentLab;

@end

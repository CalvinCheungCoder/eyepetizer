//
//  CustomSegment.h
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegment : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *nameArray;

@property (nonatomic, strong) NSArray *controllers;

@property (nonatomic, strong) UIView *segmentView;

@property (nonatomic, strong) UIScrollView *segmentScrollV;

@property (nonatomic, strong) UILabel *topLine;

@property (nonatomic, strong) UILabel *line;

@property (nonatomic, strong) UIButton *seleBtn;

@property (nonatomic, strong) UILabel *down;

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray*)controllers titleArray:(NSArray*)titleArray ParentController:(UIViewController*)parentC;

@end

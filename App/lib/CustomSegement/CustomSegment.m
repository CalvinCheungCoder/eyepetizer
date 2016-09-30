//
//  CustomSegment.m
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "CustomSegment.h"

@implementation CustomSegment

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC
{
    if ( self=[super initWithFrame:frame])
    {
        self.controllers = controllers;
        self.nameArray = titleArray;
        
        self.segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.segmentView.tag = 50;
        [self addSubview:self.segmentView];
        
        self.segmentScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, ScreenHeight - 40)];
        self.segmentScrollV.contentSize = CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.segmentScrollV.delegate = self;
        self.segmentScrollV.showsHorizontalScrollIndicator = NO;
        self.segmentScrollV.pagingEnabled = NO;
        self.segmentScrollV.bounces = YES;
        [self addSubview:self.segmentScrollV];
        
        for (int i = 0;i < self.controllers.count;i ++)
        {
            UIViewController *contr = self.controllers[i];
            [self.segmentScrollV addSubview:contr.view];
            contr.view.frame = CGRectMake(i*frame.size.width, 0, frame.size.width,ScreenHeight);
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        for (int i = 0;i < self.controllers.count;i ++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count, 40);
            btn.tag = i;
            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            if (i == 0)
            {   btn.selected = YES;
                self.seleBtn = btn;
                btn.titleLabel.font = [UIFont systemFontOfSize:12];
            } else {
                btn.selected = NO;
            }
            [self.segmentView addSubview:btn];
        }
        CGFloat lineWidth = frame.size.width/self.controllers.count/2;
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(lineWidth/2,30, lineWidth, 0.5)];
        self.line.backgroundColor = [UIColor grayColor];
        self.line.tag = 100;
        [self.segmentView addSubview:self.line];
        
        self.topLine = [[UILabel alloc]initWithFrame:CGRectMake(lineWidth/2, 10, lineWidth, 0.5)];
        self.topLine.backgroundColor = [UIColor grayColor];
        self.topLine.tag = 101;
        [self.segmentView addSubview:self.topLine];
        
        //        self.down = [[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, frame.size.width, 0.5)];
        //        self.down.backgroundColor = [UIColor grayColor];
        //        [self.segmentView addSubview:self.down];
    }
    return self;
}

- (void)Click:(UIButton*)sender
{
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.seleBtn.selected = NO;
    self.seleBtn = sender;
    self.seleBtn.selected = YES;
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint frame = self.line.center;
        frame.x = self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center = frame;
        
        CGPoint frame2 = self.topLine.center;
        frame2.x = self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.topLine.center = frame2;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:sender userInfo:nil];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint frame = self.line.center;
        frame.x = self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center = frame;
        
        CGPoint frame2 = self.topLine.center;
        frame2.x = self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.topLine.center = frame2;
    }];
    UIButton *btn = (UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected = NO;
    self.seleBtn = btn;
    self.seleBtn.selected = YES;
}


@end

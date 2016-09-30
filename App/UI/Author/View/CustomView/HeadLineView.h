//
//  HeadLineView.h
//  App
//
//  Created by CalvinCheung on 16/9/30.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headLineDelegate <NSObject>

@optional

- (void)refreshHeadLine:(NSInteger)currentIndex;

@end

@interface HeadLineView : UIView

@property (nonatomic, assign) NSInteger CurrentIndex;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, assign) id<headLineDelegate>delegate;

@end

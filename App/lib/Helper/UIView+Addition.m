
//
//  Created by 张丁豪 on 15/7/29.
//  Copyright (c) 2015年 张丁豪. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

- (CGFloat)sd_height
{
    return self.frame.size.height;
}

- (void)setSd_height:(CGFloat)sd_height
{
    CGRect temp = self.frame;
    temp.size.height = sd_height;
    self.frame = temp;
}

- (CGFloat)sd_width
{
    return self.frame.size.width;
}

- (void)setSd_width:(CGFloat)sd_width
{
    CGRect temp = self.frame;
    temp.size.width = sd_width;
    self.frame = temp;
}


- (CGFloat)sd_y
{
    return self.frame.origin.y;
}

- (void)setSd_y:(CGFloat)sd_y
{
    CGRect temp = self.frame;
    temp.origin.y = sd_y;
    self.frame = temp;
}

- (CGFloat)sd_x
{
    return self.frame.origin.x;
}

- (void)setSd_x:(CGFloat)sd_x
{
    CGRect temp = self.frame;
    temp.origin.x = sd_x;
    self.frame = temp;
}

/************************************/

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setXOffset:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setYOffset:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end


//
//  Created by 张丁豪 on 15/7/28.
//  Copyright (c) 2015年 张丁豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Factory : NSObject


+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame target:(id)target tag:(NSInteger)tag selector:(SEL)selector;
+ (UIButton *)createButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name title:(NSString *)title;
+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame target:(id)target selector:(SEL)selector font:(UIFont *)font tintColor:(UIColor *)tintcolor backgroundColor:(UIColor *)backColor;

+ (UIButton *)createButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag normalImage:(NSString *)normalName seleImage:(NSString *)seleName title:(NSString *)title font:(UIFont *)font tintColor:(UIColor *)tintcolor;


+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame;
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size;
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text ;

+ (UIView *)createViewWithBackgroundColor:(UIColor *)color frame:(CGRect)frame;

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)name;

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)string delegate:(id <UITextFieldDelegate>)delegate tag:(NSInteger)tag;

@end


//
//  Created by 张丁豪 on 15/7/28.
//  Copyright (c) 2015年 张丁豪. All rights reserved.
//

#import "Factory.h"

@implementation Factory

/*****************************************************************************************************************************************/
+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame target:(id)target tag:(NSInteger)tag selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    button.layer.cornerRadius = 3.f;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor colorWithRed:0.3 green:0.8f blue:1.f alpha:1.f];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name title:(NSString *)title {
    UIButton *button = nil;
    if (name) {
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        if (title) {
            [button setTitle:title forState:UIControlStateNormal];
        }
    }else if (title) {
        
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
    }
    button.frame = frame;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame target:(id)target selector:(SEL)selector font:(UIFont *)font tintColor:(UIColor *)tintcolor backgroundColor:(UIColor *)backColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.layer.cornerRadius = 6.f;
    button.layer.masksToBounds = YES;
    button.tintColor = tintcolor;
    button.titleLabel.font = font;
    button.backgroundColor = backColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)createButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag normalImage:(NSString *)normalName seleImage:(NSString *)seleName title:(NSString *)title font:(UIFont *)font tintColor:(UIColor *)tintcolor{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    button.tintColor = tintcolor;
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    
    button.layer.cornerRadius = 5.f;

    [button setBackgroundImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:seleName] forState:UIControlStateSelected];
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/*****************************************************************************************************************************************/
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:24.f];
    
    [label sizeToFit];
    return label;
}

+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

/*****************************************************************************************************************************************/
+ (UIView *)createViewWithBackgroundColor:(UIColor *)color frame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

/*****************************************************************************************************************************************/
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)name {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image  = [UIImage imageNamed:name];
    return imageView;
}

/*****************************************************************************************************************************************/
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)string delegate:(id<UITextFieldDelegate>)delegate tag:(NSInteger)tag{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = string;
    
    textField.delegate = delegate;
    
    textField.tag = tag;
    return textField;
    
}

@end


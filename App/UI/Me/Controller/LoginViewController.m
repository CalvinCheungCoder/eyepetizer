//
//  LoginViewController.m
//  App
//
//  Created by CalvinCheung on 16/10/3.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "LoginViewController.h"
#import "UserAgreement.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UITextField *userName;

@property (nonatomic, strong) UITextField *password;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
}

- (void)setUpUI{
    
    _backImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _backImage.image = [UIImage imageNamed:@"Login_BKG"];
    [self.view addSubview:_backImage];
    
    _shadowView = [[UIView alloc]initWithFrame:self.view.bounds];
    _shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:_shadowView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, ScreenWidth - 120, 30)];
    _titleLabel.text = @"登录后即可评论视频";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont fontWithName:MyChinFont size:18.f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    
    _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 30, 30)];
    [_closeBtn setBackgroundImage:[UIImage imageNamed:@"audio_AD_close@2x"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeThePage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeBtn];
    
    _userName = [[UITextField alloc]initWithFrame:CGRectMake(40, _titleLabel.bottom + 80, ScreenWidth - 80, 40)];
    _userName.delegate = self;
    _userName.keyboardType = UITextBorderStyleLine;
//    userName.backgroundColor = [UIColor clearColor];
    _userName.placeholder = @"点击输入手机号/Email登录";
    _userName.textColor = [UIColor whiteColor];
    [_userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.keyboardType = UIKeyboardTypeDefault;
    _userName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _userName.returnKeyType =UIReturnKeyNext;
    _userName.keyboardAppearance=UIKeyboardAppearanceDefault;
    [self.view addSubview:_userName];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(40, _userName.bottom, ScreenWidth - 80, 0.8)];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    
    _password = [[UITextField alloc]initWithFrame:CGRectMake(40, _userName.bottom + 5, ScreenWidth - 80, 40)];
    _password.delegate = self;
    _password.keyboardType = UITextBorderStyleLine;
    _password.backgroundColor = [UIColor clearColor];
    _password.placeholder = @"输入密码";
    _password.textColor = [UIColor whiteColor];
    _password.secureTextEntry = YES;
    [_password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _password.textAlignment = NSTextAlignmentCenter;
    _password.keyboardType = UIKeyboardTypeDefault;
    _password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _password.returnKeyType = UIReturnKeyDone;
    _password.keyboardAppearance = UIKeyboardAppearanceDefault;
    [self.view addSubview:_password];
    
    UIView *lineTwo = [[UIView alloc]initWithFrame:CGRectMake(40, _password.bottom, ScreenWidth - 80, 0.8)];
    lineTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineTwo];
    
    NSArray *arr = [NSArray arrayWithObjects:@"登录",@"马上注册", nil];
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake((i+1) * (ScreenWidth/4) + i * (ScreenWidth/4) - 40, _password.bottom + 25, 80, 40);
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        btn.tag = i;
        [self.view addSubview:btn];
    }
    
    NSArray *loginArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"share_sina_n@2x"],
                         [UIImage imageNamed:@"share_weixin@2x"],
                         [UIImage imageNamed:@"share_qq@2x"], nil];
    for (int i = 0; i < 3; i ++) {
        UIButton *loginBtn = [[UIButton alloc]init];
        loginBtn.frame = CGRectMake((i + 1) * (ScreenWidth/6) + i * (ScreenWidth/6) - 25, ScreenHeight - 70, 50, 50);
        [loginBtn setBackgroundImage:loginArr[i] forState:UIControlStateNormal];
        [self.view addSubview:loginBtn];
    }
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 85, ScreenWidth, 0.8)];
    bottomLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomLine];
    
    for (int i = 0; i < 2; i ++) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake((i+1) * (ScreenWidth/3), bottomLine.bottom + 30, 0.8, 25)];
        line.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:line];
    }
    
    NSString *aStr = @"登录或者注册即同意开眼用户服务协议";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:aStr];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(0,11)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,11)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(11,6)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(11,6)];
    
    UIButton *butn = [[UIButton alloc]init];
    [butn setBackgroundColor:[UIColor clearColor]];
    butn.frame = CGRectMake(ScreenWidth/2 - 120, ScreenHeight - 130, 240, 20);
    [butn setAttributedTitle:str forState:UIControlStateNormal];
    [butn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butn];
}

- (void)click{
    
    UserAgreement *user = [[UserAgreement alloc]init];
    [self presentViewController:user animated:YES completion:nil];
}


- (void)closeThePage{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    return YES;
}

@end

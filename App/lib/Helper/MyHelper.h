
//
//  Created by 张丁豪 on 15/8/3.
//  Copyright (c) 2015年 张丁豪. All rights reserved.
//

#ifndef UIControlDemo_MyHelper_h
#define UIControlDemo_MyHelper_h

#define Default 44

#define LeftDistance 10

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define RightDistance 10

#define ControlDistance 20
//安全释放宏
#define Release_Safe(_control) [_control release], _control = nil;

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.f)

#define RandomColor RGB(arc4random()%256,arc4random()%256,arc4random()%256)

#define LDColorHex(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]

#define BASECOLOR [UIColor colorWithRed:1 green:.78 blue:.27 alpha:1]

#ifdef DEBUG
#define MyLog(FORMAT, ...) fprintf(stderr,"%s: 第%d行\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else
#define MyLog(...)
#endif

#endif






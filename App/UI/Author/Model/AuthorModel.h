//
//  AuthorModel.h
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorModel : NSObject

// icon
@property (nonatomic, copy) NSString *iconImage;
// 作者
@property (nonatomic, copy) NSString *authorLabel;
// 视频数量
@property (nonatomic, copy) NSString *videoCount;
// 简介
@property (nonatomic, copy) NSString *desLabel;

+ (instancetype)tgWithDict:(NSDictionary *)dict;

@end

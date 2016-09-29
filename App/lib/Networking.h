//
//  Networking.h
//  App
//
//  Created by CalvinCheung on 16/9/29.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Networking : NSObject

// 请求成功之后回调的 Block
typedef void(^SuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);

// 请求失败之后回调的 Block
typedef void(^FailBlock) (AFHTTPRequestOperation *operation, NSError *error);

// 封装Get请求方法
+ (void)requestDataByURL:(NSString *)URL success:(SuccessBlock)success failBlock:(FailBlock)fail;

@end

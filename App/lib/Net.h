//
//  Net.h
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#ifndef Net_h
#define Net_h

// 发现
#define discovery @"http://baobab.wandoujia.com/api/v3/discovery"
// 类别
#define categate @"http://baobab.wandoujia.com/api/v1/categories.Bak?"
// 每日列表
#define dailyList @"http://baobab.wandoujia.com/api/v1/feed.bak?num=%ld&date=%@"
// 作者
#define Author @"http://baobab.wandoujia.com/api/v3/tabs/pgcs/more?start=0&num=10"
#define AuthorDetail1 @"http://baobab.wandoujia.com/api/v3/pgc/videos?_s=4667dd0eacb22bce6099c0d2c1dd5886&f=iphone&net=wifi&num=20&p_product=EYEPETIZER_IOS&pgcId="
#define AuthorDetail2 @"&start=0&strategy=date&u=8141e05d14a4cabf8464f21683ad382c9df8d55e&v=2.7.0&vc=1305"

#define AuthorShare1 @"http://baobab.wandoujia.com/api/v3/pgc/videos?_s=fb319be3889af5cbd86dcf3b048e9e8b&f=iphone&net=wifi&num=20&p_product=EYEPETIZER_IOS&pgcId="
#define AuthorShare2 @"&start=0&strategy=shareCount&u=8141e05d14a4cabf8464f21683ad382c9df8d55e&v=2.7.0&vc=1305"

// 类别内分享排行榜
#define ShareTop1 @"http://baobab.wandoujia.com/api/v3/videos?_s=84dcbd31e142fd912326d4f92f25606f&categoryId="
#define ShareTop2 @"&f=iphone&net=wifi&num=20&p_product=EYEPETIZER_IOS&start=0&strategy=shareCount&u=8141e05d14a4cabf8464f21683ad382c9df8d55e&v=2.7.0&vc=1305"


// 专题
#define ZhuanTi1 @"http://baobab.wandoujia.com/api/v3/lightTopics/"
#define ZhuanTi2 @"?_s=a79330319730972fbf185bd61e331e04&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=8141e05d14a4cabf8464f21683ad382c9df8d55e&v=2.7.0&vc=1305"

// 萌宠
#define MengChongUrl @"http://baobab.wandoujia.com/api/v3/videos?_s=5bd6dd795c645502b7ebbc9980c7322e&categoryId=26"

// PopularUrl
#define PopularUrl @"http://baobab.wandoujia.com/api/v3/ranklist?_s=70fe21a9017cd00bd7390c82ca130cd3&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&strategy=weekly&u=8141e05d14a4cabf8464f21683ad382c9df8d55e&v=2.7.0&vc=1305"

#define PopularMonth @"http://baobab.wandoujia.com/api/v3/ranklist?_s=ad3563d12d394bbe78b043315f670c2c&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&strategy=monthly&u=8141e05d14a4cabf8464f21683ad382c9df8d55e&v=2.7.0&vc=1305"

#define PopularAll @"http://baobab.wandoujia.com/api/v3/ranklist?_s=d338bb73d852e2ede36ae280f8189e25&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&strategy=historical&u=8141e05d14a4cabf8464f21683ad382c9df8d55e&v=2.7.0&vc=1305"

// TopUrl
#define TopUrl @"http://baobab.wandoujia.com/api/v3/specialTopics?_s=44e4ee05b1f5d1efd3e30735e81230b2"


#define MyChinFont @"FZLTZCHJW--GB1-0"

#define MyChinFontTwo @"FZLTXIHJW--GB1-0"

#define MyEnFont @"Chalkduster"

#define MyEnFontTwo @"Lobster 1.4"

#endif /* Net_h */

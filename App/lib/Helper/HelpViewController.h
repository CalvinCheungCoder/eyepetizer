//
//  HelpViewController.h
//  XieYingEchoPlay
//
//  Created by 张东良 on 15/12/22.
//  Copyright © 2015年 张东良. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Addition.h"
#import "Factory.h"
#import "MyHelper.h"

@interface HelpViewController : UIViewController

- (void)createNavigationLeftButton:(id)view;

- (void)createNavigationLeftButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

- (void)createNavigationRightButton:(id)view;

- (void)createNavigationRightButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;


@end

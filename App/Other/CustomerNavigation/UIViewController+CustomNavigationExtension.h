//
//  UIViewController+CustomNavigationExtension.h
//  CustomTransitions
//
//  Created by CalvinCheung on 16/9/29.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"

@interface UIViewController (CustomNavigationExtension)

@property (nonatomic, assign) BOOL Custom_fullScreenPopGestureEnabled;

@property (nonatomic, weak) CustomNavigationController *Custom_navigationController;

@end

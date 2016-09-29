//
//  CustomNavigationController.h
//  CustomTransitions
//
//  Created by CalvinCheung on 16/9/29.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (CustomWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface CustomNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *Custom_viewControllers;

@end

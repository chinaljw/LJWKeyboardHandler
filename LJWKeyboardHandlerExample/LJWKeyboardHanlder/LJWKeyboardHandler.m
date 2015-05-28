//
//  LJWKeyboardHandler.m
//  Parking
//
//  Created by ljw on 15/5/17.
//  Copyright (c) 2015年 Mark. All rights reserved.
//

#import "LJWKeyboardHandler.h"
#import "UIWindow+LJWPresentViewController.h"
#import "UIView+FirstResponderNotification.h"

@interface LJWKeyboardHandler ()

/**
 *  键盘是否出现
 */
@property (nonatomic, assign) BOOL isKeyboardShowing;

/**
 *  是否是原始位置
 */
@property (nonatomic, assign) BOOL isOrigin;

/**
 *  键盘的frame
 */
@property (nonatomic, assign) CGRect keyboardFrame;

/**
 *  第一响应者
 */
@property (nonatomic, strong) UIView *firstResponder;

/**
 *  需要被调整的视图
 */
@property (nonatomic, strong) UIView *viewNeedsToBeReset;


@end

@implementation LJWKeyboardHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self startHandling];
        self.viewNeedsToBeReset = [UIApplication sharedApplication].keyWindow.presentViewController.view;
        self.assistantHeight = 10.f;
        
    }
    return self;
}

- (UIView *)viewNeedsToBeReset
{
    if (!_viewNeedsToBeReset) {
        _viewNeedsToBeReset = [UIApplication sharedApplication].keyWindow.presentViewController.view;
    }
    return _viewNeedsToBeReset;
}


- (void)startHandling
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFirstResponderChanged:) name:LJWFirstResponderChanged object:nil];
}

- (void)stopHandling
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LJWFirstResponderChanged object:nil];
}

- (void)willKeyboardShow:(NSNotification *)notification
{
    self.isKeyboardShowing = YES;
    
    self.keyboardFrame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    [self resetTheViewNeedsToBeResetAppropraitly];
    
}

- (void)willKeyboardHide:(NSNotification *)notification
{
    self.isKeyboardShowing = NO;
    
    self.keyboardFrame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    [self resetTheViewNeedsToBeResetAppropraitly];
    
}

- (void)resetTheViewNeedsToBeResetAppropraitly
{
    
//    NSLog(@"%@", NSStringFromCGRect(self.firstResponder.frame));
    
    UIView *tempSuperView = [[UIView alloc] initWithFrame:self.viewNeedsToBeReset.frame];
    UIView *tempSuberView = [[UIView alloc] initWithFrame:self.firstResponder.frame];
    [tempSuperView addSubview:tempSuberView];
    [self.firstResponder.window addSubview:tempSuperView];
    
    CGRect firstResponderFrameInWindow = [tempSuberView convertRect:tempSuberView.bounds toView:self.firstResponder.window];
    
    [tempSuperView removeFromSuperview];
    
    if (self.firstResponder) {
        
        if (self.keyboardFrame.origin.y < firstResponderFrameInWindow.origin.y + firstResponderFrameInWindow.size.height + self.assistantHeight) {
            
            [self addBoundsChangeAnimationFrome:self.viewNeedsToBeReset.bounds to:CGRectMake(0, (firstResponderFrameInWindow.origin.y + firstResponderFrameInWindow.size.height - self.keyboardFrame.origin.y + self.assistantHeight), self.viewNeedsToBeReset.frame.size.width, self.viewNeedsToBeReset.frame.size.height) inView:self.viewNeedsToBeReset];
            
            self.isOrigin = NO;
            
        }
        else
        {
            [self setOrigin];
        }
        
    }
    else
    {
        [self setOrigin];
    }
    
}

- (void)setOrigin
{
    if (self.isOrigin) {
        return;
    }
    
    [self addBoundsChangeAnimationFrome:self.viewNeedsToBeReset.bounds to:self.viewNeedsToBeReset.frame inView:self.viewNeedsToBeReset];
    
    self.isOrigin = YES;
}

- (void)addBoundsChangeAnimationFrome:(CGRect)from to:(CGRect)to inView:(UIView *)view
{
    
    [UIView animateWithDuration:0.25 animations:^{
        view.bounds = to;
    }];

}

- (void)dealloc
{
//    NSLog(@"%@ dealloc", self);
    [self stopHandling];
}

#pragma mark - 如果缺少类目请使用此方法获取presentViewController
/**
 *  递归获取当前展示的viewController请传入keywindow的根视图
 *
 *  @param currentViewController 当前的vc
 *
 *  @return presentVC
 */
- (UIViewController *)getPresentViewController:(UIViewController *)currentViewController
{
    
    if ([currentViewController isKindOfClass:[UINavigationController class]]) {
        return [self getPresentViewController:[(UINavigationController *)currentViewController topViewController]];
    }
    
    if ([currentViewController isKindOfClass:[UITabBarController class]]) {
        return [self getPresentViewController:[(UITabBarController *)currentViewController selectedViewController]];
    }
    
    if ([currentViewController presentingViewController]) {
        return [self getPresentViewController:[currentViewController presentingViewController]];
    }
    
    return currentViewController;
}

+ (instancetype)shareHandler
{
    static LJWKeyboardHandler *s_Handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_Handler = [[LJWKeyboardHandler alloc] init];
    });
    
    return s_Handler;
}

- (void)didFirstResponderChanged:(NSNotification *)notification
{
    
    if (self.firstResponder == notification.userInfo[@"firstResponder"]) {
        return;
    }
    
    self.firstResponder = notification.userInfo[@"firstResponder"];
    
    if (self.isKeyboardShowing) {
        [self resetTheViewNeedsToBeResetAppropraitly];
    }

}

@end

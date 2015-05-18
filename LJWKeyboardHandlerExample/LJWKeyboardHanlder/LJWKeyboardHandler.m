//
//  LJWKeyboardHandler.m
//  Parking
//
//  Created by ljw on 15/5/17.
//  Copyright (c) 2015年 Mark. All rights reserved.
//

#import "LJWKeyboardHandler.h"

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
 *  键盘的fram
 */
@property (nonatomic, assign) CGRect keyboardFrame;

@end

@implementation LJWKeyboardHandler

- (UIView *)viewNeedsToBeReset
{
    if (!_viewNeedsToBeReset) {
        
        _viewNeedsToBeReset = [UIApplication sharedApplication].keyWindow.presentViewController.view;
        
    }
    
    return _viewNeedsToBeReset;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        [[UIApplication sharedApplication].keyWindow addObserver:self forKeyPath:@"firstResponder" options:NSKeyValueObservingOptionNew context:nil];
        self.assistantHeight = 10.f;
    }
    return self;
}

- (instancetype)initWithTheViewNeedsToBeReset:(UIView *)view
{
    self = [self init];
    
    if (self) {
        self.viewNeedsToBeReset = view;
    }
    
    return self;
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

    UIView *firstResponder = [self keyWindowFirstResponder];
    
//    LJWLog(@"%@", NSStringFromCGRect(firstResponder.frame));
    
    CGRect firstResponderFrameInWindow = [firstResponder convertRect:firstResponder.bounds toView:[UIApplication sharedApplication].keyWindow.presentViewController.view];
    
    if (firstResponder) {
        
        if (self.keyboardFrame.origin.y < firstResponderFrameInWindow.origin.y + firstResponderFrameInWindow.size.height) {
            
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
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    animation.fromValue = [NSValue valueWithCGRect:from];
//    animation.toValue = [NSValue valueWithCGRect:to];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.speed = 0.8;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    view.layer.bounds = to;
//    [view.layer addAnimation:animation forKey:@"a"];
    
    [UIView animateWithDuration:0.25 animations:^{
        view.bounds = to;
    }];

}

- (UIView *)keyWindowFirstResponder
{
    
    SEL firstResponderSEL = NSSelectorFromString(@"firstResponder");
    
    if ([[UIApplication sharedApplication].keyWindow respondsToSelector:firstResponderSEL]) {
        
       return [[UIApplication sharedApplication].keyWindow performSelector:firstResponderSEL];
        
    }
    
    return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (self.isKeyboardShowing) {
        [self resetTheViewNeedsToBeResetAppropraitly];
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[UIApplication sharedApplication].keyWindow removeObserver:self forKeyPath:@"firstResponder"];
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


@end

//
//  LJWKeyboardHandler.h
//  Parking
//
//  Created by ljw on 15/5/17.
//  Copyright (c) 2015年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LJWKeyboardHandler : NSObject

/**
 *  需要被调整的视图
 */
@property (nonatomic, strong) UIView *viewNeedsToBeReset;

/**
 *  辅助的高度
 */
@property (nonatomic, assign) CGFloat assistantHeight;

/**
 *  初始化方法
 *
 *  @param view 需要被调整的视图
 *
 *  @return self
 */
- (instancetype)initWithTheViewNeedsToBeReset:(UIView *)view;

+ (instancetype)shareHandler;

@end

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
 *  辅助的高度
 */
@property (nonatomic, assign) CGFloat assistantHeight;

/**
 *  开始处理
 */
- (void)startHandling;

/**
 *  结束处理
 */
- (void)stopHandling;

@end

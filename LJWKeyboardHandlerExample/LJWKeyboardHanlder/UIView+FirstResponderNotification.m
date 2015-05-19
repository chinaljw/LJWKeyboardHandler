//
//  UIView+FirstResponderNotification.m
//  LJWKeyboardHandlerExample
//
//  Created by ljw on 15/5/19.
//  Copyright (c) 2015年 ljw. All rights reserved.
//

#import "UIView+FirstResponderNotification.h"
#import <objc/runtime.h>

@implementation UIView (FirstResponderNotification)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSEL = @selector(becomeFirstResponder);
        SEL newSEL = @selector(ljw_becomeFirstResponder);
        
        Method originMethod = class_getInstanceMethod([self class], originSEL);
        Method newMethod = class_getInstanceMethod(self.class, newSEL);
        
        if (class_addMethod(self.class, originSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            
            class_replaceMethod(self.class, newSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
            
        }
        else
        {
            method_exchangeImplementations(originMethod, newMethod);
        }

        
    });
}

- (BOOL)ljw_becomeFirstResponder
{
    
//    NSLog(@"%@ becomeFirstResponder", self);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LJWFirstResponderChanged object:nil userInfo:@{@"firstResponder":self}];
    
    return [self ljw_becomeFirstResponder];
}

@end

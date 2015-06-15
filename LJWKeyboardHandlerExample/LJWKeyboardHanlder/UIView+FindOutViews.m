//
//  UIView+FindOutViews.m
//  LJWKeyboardHandlerExample
//
//  Created by ljw on 15/6/15.
//  Copyright (c) 2015年 ljw. All rights reserved.
//

#import "UIView+FindOutViews.h"

@implementation UIView (FindOutViews)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)findOutViews:(NSArray *)viewClasses
{
    
    NSArray *subviews = self.subviews;
    
    NSMutableArray *views = [[NSMutableArray alloc] initWithCapacity:subviews.count];
    
    for (UIView *view in subviews) {
        
        BOOL isKindOf = NO;
        
        for (Class class in viewClasses) {
            if ([view isKindOfClass:class]) {
                [views addObject:view];
                isKindOf = YES;
            }
        }
        
        if (isKindOf) {
            continue;
        }
        
        [views addObjectsFromArray:[view findOutViews:viewClasses]];
        
    }
    
    return views;
}


@end

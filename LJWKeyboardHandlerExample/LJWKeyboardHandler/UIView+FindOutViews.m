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

- (NSMutableArray *)findOutAllSubViewsCanBecomeFirstResponder
{
    NSArray *subviews = self.subviews;
    
    subviews = [subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
        
        if (view1.frame.origin.y < view2.frame.origin.y) {
            return NSOrderedAscending;
        }
        else if (view1.frame.origin.y == view2.frame.origin.y)
        {
            return NSOrderedSame;
        }
        else
        {
            return NSOrderedDescending;
        }
        
    }];
    
    NSMutableArray *views = [[NSMutableArray alloc] initWithCapacity:subviews.count];
    
    for (UIView *view in subviews) {
        
        if ([view canBecomeFirstResponder]) {
            [views addObject:view];
        }
        else
        {
            [views addObjectsFromArray:[view findOutAllSubViewsCanBecomeFirstResponder]];
        }
        
    }
    
    return views;

}


@end

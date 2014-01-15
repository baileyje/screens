#import "ViewUtils.h"


@implementation ViewUtils

+(CGPoint)absoluteOrigin:(UIView *)view {
    CGPoint point = CGPointZero;
    UIView * current = view;
    while(current.superview) {
        point = [self originInParent:current];
        current = current.superview;
    }
    return point;
}

+(CGPoint)originInParent:(UIView *)view {
    return [view convertPoint:CGPointZero toView:[view superview]];
}

@end
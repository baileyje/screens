#import "Layout.h"
#import "ViewSpec.h"
#import "FrameSpec.h"
#import "AlignmentSpec.h"
#import "MarginSpec.h"
#import "LinearLayout.h"
#import "SizeSpec.h"
#import "PointSpec.h"


@implementation Layout

static Layout *BASE;

+ (Layout *)base {
    if (!BASE) {
        BASE = [Layout new];
    }
    return BASE;
}

+ (Layout *)for:(NSDictionary *)json {
    if ([json objectForKey:@"type"]) {
        NSString *type = [json objectForKey:@"type"];
        if ([type isEqualToString:@"linear"]) {
            return [[LinearLayout alloc] initWith:json];
        }
    }
    return self.base;
}

- (void)applyWrappedSizeTo:(ViewSpec *)view {
    int wrappedWidth = 0;
    int wrappedHeight = 0;
    for (ViewSpec *child in view.subviewSpecs) {
        int rightMargin = child.marginSpec ? MAX(child.marginSpec.right, 0) : 0;
        wrappedWidth = MAX(wrappedWidth, child.frameSpec.point.x + child.frameSpec.size.width + rightMargin);

        int bottmMargin = child.marginSpec ? MAX(child.marginSpec.bottom, 0) : 0;
        wrappedHeight = MAX(wrappedHeight, child.frameSpec.point.y + child.frameSpec.size.height + bottmMargin);
    }
    if (view.frameSpec.size.wrapWidth) {
        view.frameSpec.size.width = wrappedWidth;
    }
    if (view.frameSpec.size.wrapHeight) {
        view.frameSpec.size.height = wrappedHeight;
    }
}

- (int)widthFor:(ViewSpec *)view in:(ViewSpec *)parent {
    if (view.frameSpec && view.frameSpec.size && view.frameSpec.size.width > 0) {
        return view.frameSpec.size.width;
    }
    int marginLeft = view.frameSpec ? MAX(view.frameSpec.point.x, 0) : 0;
    int marginRight = 0;
    if (view.marginSpec) {
        marginLeft += MAX(view.marginSpec.left, 0);
        marginRight = MAX(view.marginSpec.right, 0);
    }
    return parent.frameSpec.size.width - marginLeft - marginRight;
}

- (int)heightFor:(ViewSpec *)view in:(ViewSpec *)parent {
    if (view.frameSpec && view.frameSpec.size && view.frameSpec.size.height > 0) {
        return view.frameSpec.size.height;
    }
    int marginTop = view.frameSpec ? MAX(view.frameSpec.point.y, 0) : 0;
    int marginBottom = 0;
    if (view.marginSpec) {
        marginTop += MAX(view.marginSpec.top, 0);
        marginBottom = MAX(view.marginSpec.bottom, 0);
    }
    return parent.frameSpec.size.height - marginTop - marginBottom;
}

- (int)xFor:(ViewSpec *)view in:(ViewSpec *)parent {
    if (view.frameSpec && view.frameSpec.point && view.frameSpec.point.x >= 0) {
        return view.frameSpec.point.x;
    } else if (view.alignmentSpec) {
        return [view.alignmentSpec alignmentFor:view.frameSpec.size in:parent.frameSpec.size].x;
    } else if (view.marginSpec && view.marginSpec.left >= 0) {
        return view.marginSpec.left;
    } else if (view.marginSpec && view.marginSpec.right >= 0) {
        return parent.frameSpec.size.width - view.frameSpec.size.width - view.marginSpec.right;
    }
    return 0;
}

- (int)yFor:(ViewSpec *)view in:(ViewSpec *)parent {
    if (view.frameSpec && view.frameSpec.point && view.frameSpec.point.y >= 0) {
        return view.frameSpec.point.y;
    } else if (view.alignmentSpec) {
        return [view.alignmentSpec alignmentFor:view.frameSpec.size in:parent.frameSpec.size].y;
    } else if (view.marginSpec && view.marginSpec.top >= 0) {
        return view.marginSpec.top;
    } else if (view.marginSpec && view.marginSpec.bottom >= 0) {
        return parent.frameSpec.size.height - view.frameSpec.size.height - view.marginSpec.bottom;
    }
    return 0;
}


- (void)    layoutSubviews:(ViewSpec *)parent {
    for (ViewSpec *subview in parent.subviewSpecs) {
        subview.frameSpec.size.width = [self widthFor:subview in:parent];
        subview.frameSpec.size.height = [self heightFor:subview in:parent];
        [subview layoutSubviews];
        [self applyWrappedSizeTo:subview];
        subview.frameSpec.point.x = [self xFor:subview in:parent];
        subview.frameSpec.point.y = [self yFor:subview in:parent];
    }
}

@end
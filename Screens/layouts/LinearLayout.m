#import "LinearLayout.h"
#import "ViewSpec.h"
#import "FrameSpec.h"
#import "MarginSpec.h"
#import "SizeSpec.h"
#import "PointSpec.h"


typedef enum {
    LinearLayoutDirectionHorizontal,
    LinearLayoutDirectionVertical
} LinearLayoutDirection;

@implementation LinearLayout {
    LinearLayoutDirection direction;
}

- (id)initWith:(NSDictionary *)json {
    self = [super init];
    NSString *directionType = [json objectForKey:@"direction"];
    if (directionType && ([directionType isEqualToString:@"h"] || [directionType isEqualToString:@"horizontal"])) {
        direction = LinearLayoutDirectionHorizontal;
    } else {
        direction = LinearLayoutDirectionVertical;
    }
    return self;
}

- (void)layoutSubviews:(ViewSpec *)parent {
    int yOffset = 0;
    int xOffset = 0;

    for (ViewSpec *subview in parent.subviewSpecs) {
        subview.frameSpec.size.width = [self widthFor:subview in:parent];
        subview.frameSpec.size.height = [self heightFor:subview in:parent];
        [subview layoutSubviews];
        [self applyWrappedSizeTo:subview];

        switch (direction) {
            case LinearLayoutDirectionHorizontal: {
                subview.frameSpec.point.y = [self yFor:subview in:parent];
                int x = xOffset;
                if (subview.marginSpec) {
                    x += MAX(subview.marginSpec.left, 0);
                    xOffset = x;
                    xOffset += MAX(subview.marginSpec.right, 0);
                }
                subview.frameSpec.point.x = x;
                xOffset += subview.frameSpec.size.width;
                break;
            }
            default: {
                subview.frameSpec.point.x = [self xFor:subview in:parent];
                int y = yOffset;
                if (subview.marginSpec) {
                    y += MAX(subview.marginSpec.top, 0);
                    yOffset = y;
                    yOffset += MAX(subview.marginSpec.bottom, 0);
                }
                subview.frameSpec.point.y = y;
                yOffset += subview.frameSpec.size.height;
            }
        }
    }
}

@end
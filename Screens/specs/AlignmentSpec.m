#import "AlignmentSpec.h"
#import "SizeSpec.h"
#import "View.h"
#import "PointSpec.h"

typedef enum {
    VerticalAlignmentCenter,
    VerticalAlignmentTop,
    VerticalAlignmentBottom
} VerticalAlignment;

typedef enum {
    HorizontalAlignmentCenter,
    HorizontalAlignmentLeft,
    HorizontalAlignmentRight
} HorizontalAlignment;


@implementation AlignmentSpec {
    HorizontalAlignment horizontalAlignment;
    VerticalAlignment verticalAlignment;
}

static AlignmentSpec *DEFAULT;

+ (AlignmentSpec *)default {
    if (!DEFAULT) {
        DEFAULT = [[AlignmentSpec alloc] init];
    }
    return DEFAULT;
}

static AlignmentSpec *CENTERED;

+ (AlignmentSpec *)centered {
    if (!CENTERED) {
        CENTERED = [[AlignmentSpec alloc] initWith:[NSDictionary dictionaryWithObjectsAndKeys:@"c", @"v", @"c", @"h", nil]];
    }
    return CENTERED;
}

- (id)init {
    return [self initWithHorizontle:HorizontalAlignmentLeft viertical:VerticalAlignmentTop];
}

- (id)initWithHorizontle:(HorizontalAlignment)_horizontalAlignment viertical:(VerticalAlignment)_verticalAlignment {
    self = [super init];
    verticalAlignment = _verticalAlignment;
    horizontalAlignment = _horizontalAlignment;
    return self;
}

- (id)initWith:(NSDictionary *)json {
    verticalAlignment = VerticalAlignmentTop;
    if ([json objectForKey:@"v"]) {
        NSString *alignment = [json objectForKey:@"v"];
        if ([alignment isEqualToString:@"bottom"] || [alignment isEqualToString:@"b"]) {
            verticalAlignment = VerticalAlignmentBottom;
        } else if ([alignment isEqualToString:@"center"] || [alignment isEqualToString:@"c"]) {
            verticalAlignment = VerticalAlignmentCenter;
        }
    }
    horizontalAlignment = HorizontalAlignmentLeft;
    if ([json objectForKey:@"h"]) {
        NSString *alignment = [json objectForKey:@"h"];
        if ([alignment isEqualToString:@"right"] || [alignment isEqualToString:@"r"]) {
            horizontalAlignment = HorizontalAlignmentRight;
        }
        else if ([alignment isEqualToString:@"center"] || [alignment isEqualToString:@"c"]) {
            horizontalAlignment = HorizontalAlignmentCenter;
        }
    }
    return [self initWithHorizontle:horizontalAlignment viertical:verticalAlignment];
}

- (PointSpec *)alignmentFor:(SizeSpec *)childSize in:(SizeSpec *)parentSize {
    float x;
    switch (horizontalAlignment) {
        case HorizontalAlignmentRight: {
            x = parentSize.width - childSize.width;
            break;
        }
        case HorizontalAlignmentCenter: {
            x = (parentSize.width / 2) - (childSize.width / 2);
            break;
        }
        default: {
            x = 0;
            break;
        }
    }
    float y;
    switch (verticalAlignment) {
        case VerticalAlignmentBottom: {
            y = parentSize.height - childSize.height;
            break;
        }
        case VerticalAlignmentCenter: {
            y = (parentSize.height - childSize.height) / 2 + 3;
            break;
        }
        default: {
            y = 0;
            break;
        }
    }
    return [[PointSpec alloc] initWithX:x y:y];
}

- (void)align:(UIView *)view in:(UIView *)parent {
    PointSpec *point = [self alignmentFor:[[SizeSpec alloc] initWithSize:view.bounds.size] in:[[SizeSpec alloc] initWithSize:parent.bounds.size]];
    view.frame = CGRectMake(point.x, point.y, view.bounds.size.width, view.bounds.size.height);
}

@end
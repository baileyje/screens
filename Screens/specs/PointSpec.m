#import "PointSpec.h"
#import "SpecUtils.h"


@implementation PointSpec

@synthesize x, y;

static PointSpec *ZERO = nil;

+ (PointSpec *)zero {
    if (!ZERO) {
        ZERO = [[PointSpec alloc] initWithX:0 y:0];
    }
    return ZERO;
}

- (id)initWithX:(int)_x y:(int)_y {
    self = [super init];
    self.x = _x;
    self.y = _y;
    return self;
}

- (id)initWith:(NSDictionary *)json {
    return [self initWithX:[SpecUtils intValueFor:@[@"x"] in:json defaultValue:-1] y:[SpecUtils intValueFor:@[@"y"] in:json defaultValue:-1]];
}

- (id)initWithPoint:(CGPoint)point {
    return [self initWithX:(int) point.x y:(int) point.y];
}

- (CGPoint)asPoint {
    return CGPointMake(self.x, self.y);
}

@end
#import "FrameSpec.h"
#import "SizeSpec.h"
#import "PointSpec.h"


@implementation FrameSpec

static FrameSpec *FULL_SCREEN = nil;

@synthesize point = _point, size = _size;

+ (FrameSpec *)fullScreen {
    if (!FULL_SCREEN) {
        FULL_SCREEN = [[FrameSpec alloc] initWithPoint:[PointSpec zero] size:[SizeSpec fullScreen]];
    }
    return FULL_SCREEN;
}

- (id)initWithPoint:(PointSpec *)point size:(SizeSpec *)size {
    self = [super init];
    _point = point;
    _size = size;
    return self;
}

- (id)initWith:(NSDictionary *)json {
    PointSpec *point = [[PointSpec alloc] initWith:json];
    SizeSpec *size = [[SizeSpec alloc] initWith:json];
    return [self initWithPoint:point
                          size:size];
}

- (CGRect)rect {
    return CGRectMake(self.point.x, self.point.y, self.size.width, self.size.height);
}

@end
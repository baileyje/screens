#import "SizeSpec.h"
#import "SpecUtils.h"


@implementation SizeSpec {
    BOOL _fillWidth;
    BOOL _fillHeight;
    BOOL _wrapWidth;
    BOOL _wrapHeight;
}

@synthesize width, height, fillWidth = _fillWidth, fillHeight = _fillHeight, wrapWidth = _wrapWidth, wrapHeight = _wrapHeight;

static SizeSpec *FULL_SCREEN = nil;

+ (SizeSpec *)fullScreen {
    if (!FULL_SCREEN) {
        FULL_SCREEN = [[SizeSpec alloc] initWithWidth:1024 height:768];
    }
    return FULL_SCREEN;
}

- (id)initWithWidth:(int)_width height:(int)_height {
    self = [super init];
    self.width = _width;
    self.height = _height;
    return self;
}

- (id)initWith:(NSDictionary *)json {
    NSObject *widthValue = [SpecUtils valueFor:@[@"w", @"width"] in:json];
    NSObject *heightValue = [SpecUtils valueFor:@[@"h", @"height"] in:json];
    int _width = -1;
    if (widthValue) {
        if ([widthValue isKindOfClass:NSString .class]) {
            NSString *widthString = (NSString *) widthValue;
            if ([widthString isEqualToString:@"fill"]) {
                _fillWidth = YES;
            } else if ([widthString isEqualToString:@"wrap"]) {
                _wrapWidth = YES;
            }
        } else if ([widthValue isKindOfClass:NSNumber.class]) {
            _width = [((NSNumber *) widthValue) intValue];
        }
    }
    int _height = -1;
    if (heightValue) {
        if ([heightValue isKindOfClass:NSString .class]) {
            NSString *heightString = (NSString *) heightValue;
            if ([heightString isEqualToString:@"fill"]) {
                _fillHeight = YES;
            } else if ([heightString isEqualToString:@"wrap"]) {
                _wrapHeight = YES;
            }
        } else if ([heightValue isKindOfClass:NSNumber.class]) {
            _height = [((NSNumber *) heightValue) intValue];
        }
    }
    return [self initWithWidth:_width
                        height:_height];
}

- (id)initWithSize:(CGSize)size {
    return [self initWithWidth:(int) size.width height:(int) size.height];
}

- (CGSize)asSize {
    return CGSizeMake(self.width, self.height);
}

@end
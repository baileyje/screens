#import "MarginSpec.h"
#import "SpecUtils.h"


@implementation MarginSpec

@synthesize  left = _left, top = _top, right = _right, bottom = _bottom;

- (id)initWith:(NSObject *)json {
    self = [super init];
    if ([json isKindOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDict = (NSDictionary *) json;
        _left = [SpecUtils intValueFor:@[@"l", @"left"] in:jsonDict defaultValue:-1];
        _top = [SpecUtils intValueFor:@[@"t", @"top"] in:jsonDict defaultValue:-1];
        _right = [SpecUtils intValueFor:@[@"r", @"right"] in:jsonDict defaultValue:-1];
        _bottom = [SpecUtils intValueFor:@[@"b", @"bottom"] in:jsonDict defaultValue:-1];
    } else if ([json isKindOfClass:[NSString class]]) {
        _left = _top = _right = _bottom = [((NSString *) json) intValue];
    } else if ([json isKindOfClass:[NSNumber class]]) {
        _left = _top = _right = _bottom = [((NSNumber *) json) intValue];
    }
    return self;
}

@end
#import "ColorSpec.h"
#import "SpecUtils.h"


@interface ColorSpec ()
@property(nonatomic, strong) NSString *colorString;
@end

@implementation ColorSpec {
    int red, green, blue;
    float alpha;
}

@synthesize colorString;

- (id)initWith:(NSObject *)json {
    self = [super init];
    if ([json isKindOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDict = (NSDictionary *) json;
        red = [SpecUtils intValueFor:@[@"r", @"red"] in:jsonDict];
        green = [SpecUtils intValueFor:@[@"g", @"green"] in:jsonDict];
        blue = [SpecUtils intValueFor:@[@"b", @"blue"] in:jsonDict];
        alpha = [SpecUtils floatValueFor:@[@"a", @"alpha"] in:jsonDict defaultValue:1.0];
    } else if ([json isKindOfClass:[NSString class]]) {
        colorString = (NSString *) json;
    }
    return self;
}

- (UIColor *)asColor {
    if (self.colorString) {
        return [UIColor performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@Color", colorString])];
    }
    return [UIColor colorWithRed:((float) red) / 255.0 green:((float) green) / 255.0 blue:((float) blue) / 255.0 alpha:alpha];
};

@end
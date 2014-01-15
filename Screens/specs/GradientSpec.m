#import "GradientSpec.h"
#import "ColorSpec.h"

@interface ColorStop : NSObject
@property(nonatomic, strong) ColorSpec *color;
@property(nonatomic) float stop;

- (id)initWith:(NSDictionary *)json;
@end

@interface GradientSpec ()
@property(nonatomic, strong) NSArray *stops;
@end

@implementation GradientSpec

@synthesize stops;

- (id)initWith:(NSDictionary *)json {
    self = [super init];
    NSMutableArray *_stops = [NSMutableArray arrayWithCapacity:json.count];
    for (NSDictionary *stopJson in json) {
        [_stops addObject:[[ColorStop alloc] initWith:stopJson]];
    }
    self.stops = [NSArray arrayWithArray:_stops];
    return self;
}

- (CAGradientLayer *)asLayer {
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:stops.count];
    NSMutableArray *locations = [NSMutableArray arrayWithCapacity:stops.count];
    for (ColorStop *stop in stops) {
        [colors addObject:(id) stop.color.asColor.CGColor];
        [locations addObject:[NSNumber numberWithFloat:stop.stop]];
    }
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = colors;
    layer.locations = locations;
    return layer;
}

@end

@implementation ColorStop
@synthesize color, stop;

- (id)initWith:(NSDictionary *)json {
    self = [super init];
    self.color = [[ColorSpec alloc] initWith:[json objectForKey:@"color"]];
    self.stop = [[json objectForKey:@"stop"] floatValue];
    return self;
}

@end
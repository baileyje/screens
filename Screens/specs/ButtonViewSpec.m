#import "ButtonViewSpec.h"
#import "ButtonView.h"
#import "SpecContext.h"


@implementation ButtonViewSpec
@synthesize target;

- (void)apply:(NSDictionary *)json context:(SpecContext *)context {
    [super apply:json context:context];
    if ([json objectForKey:@"target"]) {
        self.target = [json objectForKey:@"target"];
    }
}

- (View *)asView:(ScreenManager *)screenManager {
    return [[ButtonView alloc] initWith:self manager:screenManager];
}

@end
#import "ScreenSpec.h"
#import "SpecContext.h"
#import "FrameSpec.h"

@implementation ScreenSpec

@synthesize name;

- (void)apply:(NSDictionary *)json context:(SpecContext *)context {
    self.frameSpec = FrameSpec.fullScreen;
    [super apply:json context:context];
    if ([json objectForKey:@"name"]) {
        self.name = [json objectForKey:@"name"];
    }
}

@end
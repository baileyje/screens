#import "ScrollViewSpec.h"
#import "View.h"
#import "ScreenManager.h"
#import "SpecContext.h"
#import "ScrollView.h"


@implementation ScrollViewSpec
@synthesize paging;

- (void)apply:(NSDictionary *)json context:(SpecContext *)context {
    [super apply:json context:context];
    if ([json objectForKey:@"paging"]) {
        self.paging = [[json objectForKey:@"paging"] boolValue];
    }
}

- (View *)asView:(ScreenManager *)screenManager {
    return [[ScrollView alloc] initWith:self manager:screenManager];
}

@end
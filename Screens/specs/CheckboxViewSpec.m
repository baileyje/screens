#import "CheckboxViewSpec.h"
#import "CheckboxView.h"


@implementation CheckboxViewSpec

- (void)apply:(NSDictionary *)json context:(SpecContext *)context {
    [super apply:json context:context];
    if ([json objectForKey:@"checked"]) {
        self.checked = [[json objectForKey:@"checked"] boolValue];
    }
}

- (View *)asView:(ScreenManager *)screenManager {
    return [[CheckboxView alloc] initWith:self manager:screenManager];
}

@end
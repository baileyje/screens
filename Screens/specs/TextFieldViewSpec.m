#import "TextFieldViewSpec.h"
#import "TextFieldView.h"


@implementation TextFieldViewSpec
@synthesize placeholder;

- (void)apply:(NSDictionary *)json context:(SpecContext *)context {
    [super apply:json context:context];
    if ([json objectForKey:@"placeholder"]) {
        self.placeholder = [json objectForKey:@"placeholder"];
    }
}

- (View *)asView:(ScreenManager *)screenManager {
    return [[TextFieldView alloc] initWith:self manager:screenManager];
}

@end
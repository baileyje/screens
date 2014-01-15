#import "ImageViewSpec.h"
#import "ContentSpec.h"
#import "ImageView.h"
#import "SpecContext.h"


@implementation ImageViewSpec

@synthesize content;

- (void)apply:(NSDictionary *)json context:(SpecContext *)context {
    [super apply:json context:context];
    if ([json objectForKey:@"content"]) {
        self.content = [ContentSpec from:[json objectForKey:@"content"] context:context];
    }
}

- (View *)asView:(ScreenManager *)screenManager {
    return [[ImageView alloc] initWith:self manager:screenManager];
}


@end
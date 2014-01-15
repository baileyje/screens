#import "ContentSpec.h"
#import "UrlContentSpec.h"
#import "BundleContentSpec.h"
#import "SpecContext.h"
#import "FrameSpec.h"


@implementation ContentSpec

+ (ContentSpec *)from:(NSDictionary *)json context:(SpecContext *)context {
    if ([json objectForKey:@"type"]) {
        NSString *type = [json objectForKey:@"type"];
        if ([type isEqualToString:@"url"]) {
            return [[UrlContentSpec alloc] initWith:json];
        } else if ([type isEqualToString:@"bundle"]) {
            return [[BundleContentSpec alloc] initWith:json];
        } else {
            Class extension = NSClassFromString(type);
            if (extension) {
                return [[extension alloc] initWith:json];
            }
        }

    }
    return [ContentSpec new];
}

- (void)get:(ContentUrlHandler)handler {
    handler(nil);
}

@end
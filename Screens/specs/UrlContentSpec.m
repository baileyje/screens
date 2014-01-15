#import "UrlContentSpec.h"

@interface UrlContentSpec ()
@property(nonatomic, strong) NSURL *url;
@end

@implementation UrlContentSpec
@synthesize url;

- (id)initWith:(NSDictionary *)json {
    self = [super init];
    if ([json objectForKey:@"url"]) {
        self.url = [NSURL URLWithString:[json objectForKey:@"url"]];
    }
    return self;
}

- (void)get:(ContentUrlHandler)handler {
    handler(self.url);
}

@end
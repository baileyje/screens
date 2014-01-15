#import "BundleContentSpec.h"

@interface BundleContentSpec ()
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *ext;
@end

@implementation BundleContentSpec

@synthesize name, ext;

- (id)initWithName:(NSString *)_name ext:(NSString *)_ext {
    self = [super init];
    self.name = _name;
    self.ext = _ext;
    return self;
}

- (id)initWith:(NSDictionary *)json {
    return [self initWithName:[json objectForKey:@"name"] ext:[json objectForKey:@"ext"]];
}

- (void)get:(ContentUrlHandler)handler {
    handler([[NSBundle mainBundle] URLForResource:self.name withExtension:self.ext]);
}

@end
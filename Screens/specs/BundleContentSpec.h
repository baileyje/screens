#import <Foundation/Foundation.h>
#import "ContentSpec.h"


@interface BundleContentSpec : ContentSpec
- (id)initWith:(NSDictionary *)json;

- (id)initWithName:(NSString *)string ext:(NSString *)ext;
@end
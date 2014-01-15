#import <Foundation/Foundation.h>

@class SpecContext;

typedef void (^ContentUrlHandler)(NSURL *url);

@interface ContentSpec : NSObject

+(ContentSpec*)from:(NSDictionary *)json context:(SpecContext *)context;

- (void)get:(ContentUrlHandler)handler;

@end
#import "ScreenSpecsParser.h"
#import "ScreenSpec.h"
#import "SpecContext.h"
#import "SpecUtils.h"

@implementation ScreenSpecsParser

+ (NSArray *)parse:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"Error parsing json: %@", error);
        return nil;
    }
    NSArray *screensJson = [json objectForKey:@"screens"];
    NSMutableArray *screens = [NSMutableArray arrayWithCapacity:screensJson.count];
    SpecContext *context = [SpecContext new];
    if ([json objectForKey:@"fragments"]) {
        context.fragments = [json objectForKey:@"fragments"];
    }
    [screensJson enumerateObjectsUsingBlock:^(NSDictionary *screenJson, NSUInteger idx, BOOL *stop) {
        NSDictionary * mergedJson = [SpecUtils mergeFragments:screenJson context:context];
        ScreenSpec * spec = [[ScreenSpec alloc] initWith:mergedJson context:context];
        [spec layoutSubviews];
        [screens addObject:spec];
    }];
    return screens;
}

@end
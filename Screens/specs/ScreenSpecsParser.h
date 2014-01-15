#import <Foundation/Foundation.h>


@interface ScreenSpecsParser : NSObject
+ (NSArray *)parse:(NSURL *)url;
@end
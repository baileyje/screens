#import <Foundation/Foundation.h>


@interface ColorSpec : NSObject

-(id)initWith:(NSObject *)json;

-(UIColor *)asColor;

@end
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface GradientSpec : NSObject

-(id)initWith:(NSDictionary *)json;

-(CAGradientLayer *)asLayer;

@end
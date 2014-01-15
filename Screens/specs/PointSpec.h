#import <Foundation/Foundation.h>


@interface PointSpec : NSObject
@property(nonatomic) int x;
@property(nonatomic) int y;

+(PointSpec *)zero;

- (id)initWithX:(int)x y:(int)y;

- (id)initWith:(NSDictionary *)json;

- (id)initWithPoint:(CGPoint)point;

- (CGPoint)asPoint;

@end
#import <Foundation/Foundation.h>

@class SizeSpec, View;
@class PointSpec;

@interface AlignmentSpec : NSObject

+ (AlignmentSpec *)default;

+ (AlignmentSpec *)centered;

- (id)initWith:(NSDictionary *)json;

- (void)align:(UIView *)view in:(UIView *)parent;

- (PointSpec *)alignmentFor:(SizeSpec*)size in:(SizeSpec *)parent;

@end
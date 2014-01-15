#import <Foundation/Foundation.h>

@class SizeSpec;
@class PointSpec;


@interface FrameSpec : NSObject

@property(nonatomic, readonly) PointSpec *point;
@property(nonatomic, readonly) SizeSpec *size;

+ (FrameSpec *)fullScreen;

- (id)initWithPoint:(PointSpec *)point size:(SizeSpec *)size;

- (id)initWith:(NSDictionary *)json;

- (CGRect)rect;


@end
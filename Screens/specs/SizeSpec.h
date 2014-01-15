#import <Foundation/Foundation.h>


@interface SizeSpec : NSObject
@property(nonatomic) int width;
@property(nonatomic) int height;

@property(readonly) BOOL fillWidth;
@property(readonly) BOOL fillHeight;
@property(readonly) BOOL wrapWidth;
@property(readonly) BOOL wrapHeight;

+ (SizeSpec *)fullScreen;

- (id)initWithWidth:(int)width height:(int)height;

- (id)initWith:(NSDictionary *)json;

- (id)initWithSize:(CGSize)size;

- (CGSize)asSize;

@end
#import <Foundation/Foundation.h>

@class FrameSpec;
@class ViewSpec;
@class SizeSpec;


@interface Layout : NSObject

+ (Layout *)for:(NSDictionary *)json;

- (void)layoutSubviews:(ViewSpec *)parent;

- (void)applyWrappedSizeTo:(ViewSpec *)view;

- (int)widthFor:(ViewSpec *)view in:(ViewSpec *)parent;

- (int)heightFor:(ViewSpec *)view in:(ViewSpec *)parent;

- (int)xFor:(ViewSpec *)view in:(ViewSpec *)parent;

- (int)yFor:(ViewSpec *)view in:(ViewSpec *)parent;

@end
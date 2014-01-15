#import <Foundation/Foundation.h>
#import "ViewSpec.h"

@class ContentSpec;


@interface ImageViewSpec : ViewSpec

@property(nonatomic, strong) ContentSpec *content;

@end
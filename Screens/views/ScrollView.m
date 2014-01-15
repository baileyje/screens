#import "ScrollView.h"
#import "ButtonViewSpec.h"
#import "FrameSpec.h"
#import "SizeSpec.h"

@implementation ScrollView {
@private
    UIScrollView *_scrollView;
}

@synthesize scrollView = _scrollView;

- (id)initWith:(ViewSpec *)spec manager:(ScreenManager *)manager {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, spec.frameSpec.size.width, spec.frameSpec.size.height)];
    self = [super initWith:spec manager:manager];
    float maxWidth = self.bounds.size.width;
    float maxHeight = self.bounds.size.height;
    for (UIView *view in _scrollView.subviews) {
        maxWidth = MAX(maxWidth, view.frame.origin.x + view.frame.size.width);
        maxHeight = MAX(maxHeight, view.frame.origin.y + view.frame.size.height);
    }
    _scrollView.contentSize = CGSizeMake(maxWidth, maxHeight);
    [self addSubview:_scrollView];
    return self;
}

- (UIView *)viewContainer {
    return _scrollView;
}

@end
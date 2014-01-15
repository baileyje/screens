#import "ImageView.h"
#import "ImageViewSpec.h"
#import "ContentSpec.h"

@interface ImageView ()
@property(nonatomic, strong) ImageViewSpec *spec;
@end


@implementation ImageView
@synthesize spec, imageView;

//static NSOperationQueue *loadQueue;
//
//+ (NSOperationQueue *)loadQueue {
//    @synchronized (loadQueue) {
//        if (!loadQueue) {
//            loadQueue = [NSOperationQueue new];
//            loadQueue.maxConcurrentOperationCount = 3;
//        }
//        return loadQueue;
//    }
//}

- (id)initWith:(ImageViewSpec *)_spec  manager:(ScreenManager *)manager {
    self = [super initWith:_spec manager:manager];
    self.spec = _spec;

    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imageView];

    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.spec && self.spec.content) {
        [self.spec.content get:^(NSURL *url) {
            @autoreleasepool {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    imageView.image = image;
                }];
            }
        }];
    }

}


@end
#import <QuartzCore/QuartzCore.h>
#import "View.h"
#import "ViewSpec.h"
#import "FrameSpec.h"
#import "ContentSpec.h"
#import "ColorSpec.h"
#import "GradientSpec.h"
#import "ScreenManager.h"

@interface View ()
@property(nonatomic, strong) ViewSpec *spec;
@property(nonatomic, strong) NSArray *managedSubviews;
@property(nonatomic, strong) NSDictionary *subviewsById;
@end

@implementation View

@synthesize id, spec, screenManager, subviewsById, backgroundImage, managedSubviews;

- (id)initWith:(ViewSpec *)_spec manager:(ScreenManager *)manager {
    self = [super initWithFrame:_spec.frameSpec.rect];
    self.spec = _spec;
    self.id = self.spec.id;
    if (self.spec.backgroundColor) {
        self.backgroundColor = self.spec.backgroundColor.asColor;
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    if (self.spec.backgroundImage) {
        self.backgroundImage = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.spec.backgroundImage get:^(NSURL *url) {
            @autoreleasepool {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    backgroundImage.image = image;
                }];
            }
        }];
        [self addSubview:backgroundImage];
    }
    self.hidden = self.spec.hidden;
    NSMutableArray *_managedSubviews = [NSMutableArray arrayWithCapacity:self.spec.subviewSpecs.count];
    NSMutableDictionary *_subviewsById = [NSMutableDictionary dictionary];
    for (ViewSpec *viewSpec in self.spec.subviewSpecs) {
        View *view = [viewSpec asView:manager];
        if (view.id) {
            [_subviewsById setObject:view forKey:view.id];
        }
        [[self viewContainer] addSubview:view];
        [_managedSubviews addObject:view];
    }
    self.subviewsById = _subviewsById;
    self.managedSubviews = _managedSubviews;
    self.screenManager = manager;

    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self.screenManager action:@selector(back)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRecognizer];

    return self;
}

- (UIView *)viewContainer {
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (self.spec.backgroundGradient) {
        CAGradientLayer *gradientLayer = self.spec.backgroundGradient.asLayer;
        gradientLayer.frame = self.bounds;
        [self.layer insertSublayer:gradientLayer atIndex:0];
    }
    if (self.spec.cornerRadius > 0) {
        self.layer.cornerRadius = self.spec.cornerRadius;
        self.clipsToBounds = YES;
    }
}

- (View *)subview:(NSString *)subviewId {
    View *subview = [subviewsById objectForKey:subviewId];
    if (!subview) {
        for (View *view in self.managedSubviews) {
            subview = [view subview:subviewId];
            if (subview) {
                break;
            }
        }
    }
    return subview;
}

@end
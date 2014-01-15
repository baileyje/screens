#import "ButtonView.h"
#import "ButtonViewSpec.h"
#import "ScreenManager.h"
#import "ColorSpec.h"
#import "AlignmentSpec.h"


@interface ButtonView ()
@property(nonatomic, strong) ButtonViewSpec *spec;
@end


@implementation ButtonView
@synthesize spec, tapHandler;

- (id)initWith:(ButtonViewSpec *)_spec manager:(ScreenManager *)manager {
    self = [super initWith:_spec manager:manager];
    self.spec = _spec;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];

    float size = spec.size ? spec.size.floatValue : [UIFont systemFontSize];
    UIFont *font = spec.font ? [UIFont fontWithName:spec.font size:size] : [UIFont systemFontOfSize:size];
    if (self.spec.text) {
        CGSize textSize = [spec.text sizeWithFont:font constrainedToSize:self.bounds.size lineBreakMode:NSLineBreakByWordWrapping];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
        label.text = spec.text;
        if (spec.size) {
            label.font = font;
        }
        if (spec.color) {
            label.textColor = spec.color.asColor;
        }
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        [self addSubview:label];
        [AlignmentSpec.centered align:label in:self];
    }

    return self;
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
    if (self.tapHandler) {
        self.tapHandler(self);
    } else {
        [self.screenManager navigate:spec.target];
    }
}

@end
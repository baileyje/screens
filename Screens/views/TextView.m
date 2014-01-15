#import "TextView.h"
#import "TextViewSpec.h"
#import "ColorSpec.h"
#import "ScreenManager.h"
#import "AlignmentSpec.h"


@interface TextView ()
@property(nonatomic, strong) TextViewSpec *spec;
@end

@implementation TextView
@synthesize spec, label;

- (id)initWith:(TextViewSpec *)_spec manager:(ScreenManager *) manager {
    self = [super initWith:_spec manager:manager];
    self.spec = _spec;

    float size =  spec.size ? spec.size.floatValue : [UIFont systemFontSize];
    UIFont *font = spec.font ? [UIFont fontWithName:spec.font size:size] : [UIFont systemFontOfSize:size];

    CGSize textSize = [spec.text sizeWithFont:font constrainedToSize:CGSizeMake(self.bounds.size.width - self.labelOffset, self.bounds.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - self.labelOffset, textSize.height)];
    label.text = spec.text;
    if (spec.color) {
        label.textColor = spec.color.asColor;
    }
    label.font = font;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = spec.textAlignment.asAlignment;
    [self addSubview:label];

    [spec.alignmentSpec align:label in:self];
    label.frame = CGRectMake(label.frame.origin.x + self.labelOffset, label.frame.origin.y, label.frame.size.width, label.frame.size.height);

    return self;
}

-(int)labelOffset {
    return 0;
}

@end
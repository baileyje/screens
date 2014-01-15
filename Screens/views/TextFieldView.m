#import "TextFieldView.h"
#import "TextFieldViewSpec.h"
#import "ColorSpec.h"


@interface TextFieldView ()
@property(nonatomic, strong) TextFieldViewSpec *spec;
@end

@implementation TextFieldView
@synthesize spec, textField;

- (id)initWith:(TextFieldViewSpec *)_spec manager:(ScreenManager *)manager {
    self = [super initWith:_spec manager:manager];
    self.spec = _spec;

    float size = spec.size ? spec.size.floatValue : [UIFont systemFontSize];
    UIFont *font = spec.font ? [UIFont fontWithName:spec.font size:size] : [UIFont systemFontOfSize:size];

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 20, self.bounds.size.height)];
    textField.text = spec.text;
    if (spec.placeholder) {
        textField.placeholder = spec.placeholder;
    }
    if (spec.color) {
        textField.textColor = spec.color.asColor;
    }
    textField.font = font;
    textField.backgroundColor = [UIColor clearColor];
    [self addSubview:textField];
    textField.textAlignment = spec.textAlignment.asAlignment;
    textField.frame = CGRectMake(10, 2, textField.frame.size.width, textField.frame.size.height);
    return self;
}

@end
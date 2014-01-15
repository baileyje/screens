#import "CheckboxView.h"
#import "TextViewSpec.h"

@interface CheckboxView()
@property (nonatomic, strong)UISwitch * switchView;
@end


@implementation CheckboxView

@synthesize switchView;

- (id)initWith:(CheckboxView *)_spec manager:(ScreenManager *) manager {
    self = [super initWith:_spec manager:manager];
    self.switchView = [UISwitch new];
    self.switchView.frame = CGRectMake(0, 0, switchView.bounds.size.width, switchView.bounds.size.height);
    [self.switchView setOn:_spec.checked animated:NO];
    [self addSubview:switchView];
    return self;
}

- (BOOL)checked {
    return switchView.isOn;
}

- (void)setChecked:(BOOL)checked {
    [switchView setOn:checked animated:YES];
}

- (int)labelOffset {
    return 60;
}


@end
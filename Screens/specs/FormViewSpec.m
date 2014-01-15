#import "FormViewSpec.h"
#import "View.h"
#import "ScreenManager.h"
#import "FormView.h"


@implementation FormViewSpec

- (View *)asView:(ScreenManager *)screenManager {
    return [[FormView alloc] initWith:self manager:screenManager];
}

@end
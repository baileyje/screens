#import <Foundation/Foundation.h>
#import "View.h"
#import "ScrollView.h"

@class TextFieldView;

typedef void (^ActiveTextFieldCallback)(TextFieldView* textFields);

@interface FormView : ScrollView
@property (nonatomic, copy)ActiveTextFieldCallback activeTextFieldCallback;
@end
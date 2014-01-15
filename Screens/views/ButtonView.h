#import <Foundation/Foundation.h>
#import "View.h"

@class ButtonView;

typedef void (^TapHandler)(ButtonView* buttonView);

@interface ButtonView : View
@property (nonatomic, copy)TapHandler tapHandler;
@end
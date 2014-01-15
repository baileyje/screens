#import <Foundation/Foundation.h>
#import "View.h"


@interface TextView : View
@property(nonatomic, strong) UILabel *label;

-(int)labelOffset;

@end
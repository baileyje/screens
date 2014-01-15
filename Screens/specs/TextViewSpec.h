#import <Foundation/Foundation.h>
#import "View.h"
#import "ViewSpec.h"

@class AlignmentSpec;

typedef enum {
    TextViewAlignmentLeft,
    TextViewAlignmentCenter,
    TextViewAlignmentRight
} TextViewAlignment;

@interface TextViewAlignmentSpec : NSObject
-(id)initWith:(NSString *)jsonString;
-(NSTextAlignment)asAlignment;
@end

@interface TextViewSpec : ViewSpec

@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *font;
@property(nonatomic, strong) NSNumber *size;
@property(nonatomic, strong) ColorSpec *color;
@property(nonatomic, strong) TextViewAlignmentSpec *textAlignment;


@end
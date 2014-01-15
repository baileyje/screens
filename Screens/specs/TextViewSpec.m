#import "TextViewSpec.h"
#import "TextView.h"
#import "ColorSpec.h"
#import "SpecContext.h"


@interface TextViewAlignmentSpec()
+(TextViewAlignmentSpec *)default;
@end


@implementation TextViewSpec

@synthesize text, font, size, color, textAlignment;

- (void)apply:(NSDictionary *)json context:(SpecContext *)context {
    [super apply:json context:context];
    if ([json objectForKey:@"text"]) {
        self.text = [json objectForKey:@"text"];
    }
    if ([json objectForKey:@"font"]) {
        self.font = [json objectForKey:@"font"];
    }
    if ([json objectForKey:@"size"]) {
        self.size = [json objectForKey:@"size"];
    }
    if ([json objectForKey:@"color"]) {
        self.color = [[ColorSpec alloc] initWith:[json objectForKey:@"color"]];
    }
    if ([json objectForKey:@"text-alignment"]) {
        self.textAlignment = [[TextViewAlignmentSpec alloc] initWith:[json objectForKey:@"text-alignment"]];
    } else if (self.textAlignment == nil) {
        self.textAlignment = [TextViewAlignmentSpec default];
    }
}

- (View *)asView:(ScreenManager *)screenManager {
    return [[TextView alloc] initWith:self manager:screenManager];
}

@end

@implementation TextViewAlignmentSpec {
    NSTextAlignment alignment;
}

static TextViewAlignmentSpec * DEFAULT;
+(TextViewAlignmentSpec *)default {
    if(!DEFAULT) {
        DEFAULT = [[TextViewAlignmentSpec alloc] initWith:@"l"];
    }
    return DEFAULT;
}

- (id)initWith:(NSString *)jsonString {
    self = [super init];

    if ([jsonString isEqualToString:@"center"] || [jsonString isEqualToString:@"c"]) {
        alignment = NSTextAlignmentCenter;
    } else if ([jsonString isEqualToString:@"right"] || [jsonString isEqualToString:@"r"]) {
        alignment = NSTextAlignmentRight;
    } else {
        alignment = NSTextAlignmentLeft;
    }
    return self;
}

- (NSTextAlignment)asAlignment {
    return alignment;
}


@end
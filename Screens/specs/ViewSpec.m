#import "ViewSpec.h"
#import "FrameSpec.h"
#import "View.h"
#import "SpecContext.h"
#import "ButtonViewSpec.h"
#import "ImageViewSpec.h"
#import "ContentSpec.h"
#import "GradientSpec.h"
#import "ColorSpec.h"
#import "AlignmentSpec.h"
#import "MarginSpec.h"
#import "Layout.h"
#import "SpecUtils.h"
#import "PointSpec.h"
#import "SizeSpec.h"
#import "TextFieldViewSpec.h"
#import "FormViewSpec.h"
#import "ScrollViewSpec.h"
#import "CheckboxViewSpec.h"

@interface ViewSpec ()
@property(nonatomic, strong) Layout *layout;
@property(nonatomic, strong) NSDictionary *subviewSpecsById;
@end

@implementation ViewSpec

@synthesize id, frameSpec, alignmentSpec, marginSpec, backgroundColor, backgroundGradient, backgroundImage, subviewSpecs, cornerRadius, subviewSpecsById, layout, hidden;

- (id)initWith:(NSDictionary *)json context:(SpecContext *)context {
    self = [super init];

    self.layout = [Layout for:[json objectForKey:@"layout"]];

    [self apply:json context:context];

    NSArray *viewsJson = [json objectForKey:@"views"];
    NSMutableDictionary *viewSpecById = [NSMutableDictionary dictionary];
    NSMutableArray *subviews = [NSMutableArray arrayWithCapacity:viewsJson.count];
    for (NSObject *viewJson in viewsJson) {
        NSDictionary *viewJsonDict = nil;
        if ([viewJson isKindOfClass:NSDictionary.class]) {
            viewJsonDict = (NSDictionary *) viewJson;
        } else if ([viewJson isKindOfClass:NSString.class]) {
            viewJsonDict = [NSDictionary dictionaryWithDictionary:[context.fragments objectForKey:viewJson]];
        }
        ViewSpec *subviewSpec = [ViewSpec viewSpecFor:viewJsonDict context:context];
        [subviews addObject:subviewSpec];
        if (subviewSpec.id) {
            [viewSpecById setValue:subviewSpec forKey:subviewSpec.id];
        }
    }
    self.subviewSpecs = [NSArray arrayWithArray:subviews];
    self.subviewSpecsById = [NSDictionary dictionaryWithDictionary:viewSpecById];
    return self;
}

- (void)apply:(NSDictionary *)json context:(SpecContext *)context {
    if ([json objectForKey:@"id"]) {
        self.id = [json objectForKey:@"id"];
    }
    if ([json objectForKey:@"frame"]) {
        self.frameSpec = [[FrameSpec alloc] initWith:[json objectForKey:@"frame"]];
    } else if (!self.frameSpec) {
        self.frameSpec = [[FrameSpec alloc] initWithPoint:[[PointSpec alloc] initWithX:-1 y:-1] size:[[SizeSpec alloc] initWithWidth:-1 height:-1]];
    }
    if ([json objectForKey:@"alignment"]) {
        self.alignmentSpec = [[AlignmentSpec alloc] initWith:[json objectForKey:@"alignment"]];
    }
    if ([json objectForKey:@"margin"]) {
        self.marginSpec = [[MarginSpec alloc] initWith:[json objectForKey:@"margin"]];
    }
    if ([json objectForKey:@"background-color"]) {
        self.backgroundColor = [[ColorSpec alloc] initWith:[json objectForKey:@"background-color"]];
    }
    if ([json objectForKey:@"background-gradient"]) {
        self.backgroundGradient = [[GradientSpec alloc] initWith:[json objectForKey:@"background-gradient"]];
    }
    if ([json objectForKey:@"background-image"]) {
        self.backgroundImage = [ContentSpec from:[json objectForKey:@"background-image"] context:context];
    }
    if ([json objectForKey:@"corner-radius"]) {
        self.cornerRadius = [[json objectForKey:@"corner-radius"] intValue];
    }
    if ([json objectForKey:@"hidden"]) {
        self.hidden = [[json objectForKey:@"hidden"] boolValue];
    }
}

+ (ViewSpec *)viewSpecFor:(NSDictionary *)viewJson context:(SpecContext *)context {
    NSDictionary *mergedJson = [SpecUtils mergeFragments:viewJson context:context];
    if ([mergedJson objectForKey:@"type"]) {
        NSString *type = [mergedJson objectForKey:@"type"];
        if ([type isEqualToString:@"text"]) {
            return [[TextViewSpec alloc] initWith:mergedJson context:context];
        } else if ([type isEqualToString:@"image"]) {
            return [[ImageViewSpec alloc] initWith:mergedJson context:context];
        } else if ([type isEqualToString:@"button"]) {
            return [[ButtonViewSpec alloc] initWith:mergedJson context:context];
        } else if ([type isEqualToString:@"text-field"]) {
            return [[TextFieldViewSpec alloc] initWith:mergedJson context:context];
        } else if ([type isEqualToString:@"checkbox"]) {
            return [[CheckboxViewSpec alloc] initWith:mergedJson context:context];
        } else if ([type isEqualToString:@"scroll"]) {
            return [[ScrollViewSpec alloc] initWith:mergedJson context:context];
        } else if ([type isEqualToString:@"form"]) {
            return [[FormViewSpec alloc] initWith:mergedJson context:context];
        } else {
            Class extension = NSClassFromString(type);
            if (extension) {
                return [[extension alloc] initWith:mergedJson context:context];
            }
        }
    }
    return [[ViewSpec alloc] initWith:mergedJson context:context];
}

- (View *)asView:(ScreenManager *)screenManager {
    return [[View alloc] initWith:self manager:screenManager];
}

- (ViewSpec *)subview:(NSString *)subviewId {
    ViewSpec *subview = [subviewSpecsById objectForKey:subviewId];
    if (!subview) {
        for (ViewSpec *view in self.subviewSpecs) {
            subview = [view subview:subviewId];
            if (subview) {
                break;
            }
        }
    }
    return subview;
}

- (void)layoutSubviews {
    [self.layout layoutSubviews:self];
}


@end
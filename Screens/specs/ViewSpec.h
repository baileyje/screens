#import <Foundation/Foundation.h>

@class FrameSpec, ColorSpec, GradientSpec, ContentSpec, ScreenManager, SpecContext, View;
@class AlignmentSpec;
@class MarginSpec;

@interface ViewSpec : NSObject
@property(nonatomic, strong) FrameSpec *frameSpec;
@property(nonatomic, strong) AlignmentSpec *alignmentSpec;
@property(nonatomic, strong) MarginSpec *marginSpec;
@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) ContentSpec *backgroundImage;
@property(nonatomic, strong) ColorSpec *backgroundColor;
@property(nonatomic, strong) GradientSpec *backgroundGradient;
@property(nonatomic, strong) NSArray *subviewSpecs;
@property(nonatomic) int cornerRadius;
@property(nonatomic) BOOL hidden;

+ (ViewSpec *)viewSpecFor:(NSDictionary *)viewJson context:(SpecContext *)context;

- (id)initWith:(NSDictionary *)json context:(SpecContext *)context;

- (void)apply:(NSDictionary *)json context:(SpecContext *)context;

-(void)layoutSubviews;

- (View *)asView:(ScreenManager *)screenManager;

- (ViewSpec *)subview:(NSString *)id;
@end
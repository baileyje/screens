#import <Foundation/Foundation.h>

@class SpecContext;


@interface SpecUtils : NSObject

+ (NSObject *)valueFor:(NSArray *)fieldOptions in:(NSDictionary *)json;

+ (int)intValueFor:(NSArray *)fieldOptions in:(NSDictionary *)json;

+ (int)intValueFor:(NSArray *)fieldOptions in:(NSDictionary *)json defaultValue:(int)defaultValue;

+ (float)floatValueFor:(NSArray *)fieldOptions in:(NSDictionary *)json;

+ (float)floatValueFor:(NSArray *)fieldOptions in:(NSDictionary *)json defaultValue:(float)defaultValue;

+(NSDictionary *)mergeFragments:(NSDictionary *)json context:(SpecContext *)context;

@end
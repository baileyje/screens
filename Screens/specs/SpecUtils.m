#import "SpecUtils.h"
#import "SpecContext.h"


@implementation SpecUtils

+ (NSObject *)valueFor:(NSArray *)fieldOptions in:(NSDictionary *)json {
    for (NSString *field in fieldOptions) {
        if ([json objectForKey:field]) {
            return [json objectForKey:field];
        }
    }
    return nil;
}

+ (int)intValueFor:(NSArray *)fieldOptions in:(NSDictionary *)json {
    return [self intValueFor:fieldOptions in:json defaultValue:0];
}

+ (int)intValueFor:(NSArray *)fieldOptions in:(NSDictionary *)json defaultValue:(int)defaultValue {
    NSString *value = [self valueFor:fieldOptions in:json];
    if (value) {
        return [value intValue];
    }
    return defaultValue;
}


+ (float)floatValueFor:(NSArray *)fieldOptions in:(NSDictionary *)json {
    return [self intValueFor:fieldOptions in:json defaultValue:0];
}

+ (float)floatValueFor:(NSArray *)fieldOptions in:(NSDictionary *)json defaultValue:(float)defaultValue {
    NSString *value = [self valueFor:fieldOptions in:json];
    if (value) {
        return [value floatValue];
    }
    return defaultValue;
}

+ (NSDictionary *)mergeFragments:(NSDictionary *)json context:(SpecContext *)context {
    NSMutableArray *viewsJson = [NSMutableArray array];
    NSDictionary *result = json;

    NSObject *includesJson = [json objectForKey:@"include"];
    NSArray *includes = nil;
    if (includesJson) {
        if ([includesJson isKindOfClass:NSArray.class]) {
            includes = (NSArray *) includesJson;
        } else {
            includes = [NSArray arrayWithObject:includesJson];
        }
        if (context.fragments) {
            for (NSString *name in includes) {
                NSDictionary *jsonFragment = [context.fragments objectForKey:name];
                result = [self dictionaryByMerging:result with:jsonFragment];
                if (jsonFragment) {
                    if ([jsonFragment objectForKey:@"views"]) {
                        [viewsJson addObjectsFromArray:[jsonFragment objectForKey:@"views"]];
                    }
                }
            }
        }
    }

    if ([json objectForKey:@"views"]) {
        [viewsJson addObjectsFromArray:[json objectForKey:@"views"]];
    }

    NSMutableDictionary *mutableResult = [NSMutableDictionary dictionaryWithDictionary:result];
    [mutableResult setObject:viewsJson forKey:@"views"];
    return [NSDictionary dictionaryWithDictionary:mutableResult];
}

+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2 {
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [dict2 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![dict1 objectForKey:key]) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *newVal = [self dictionaryByMerging:[dict1 objectForKey:key] with:(NSDictionary *) obj];
                [result setObject:newVal forKey:key];
            } else {
                [result setObject:obj forKey:key];
            }
        }
    }];
    return (NSDictionary *) [result mutableCopy];
}


@end
#import <Foundation/Foundation.h>


@interface MarginSpec : NSObject

@property(nonatomic, readonly) int left;
@property(nonatomic, readonly) int top;
@property(nonatomic, readonly) int right;
@property(nonatomic, readonly) int bottom;

- (id)initWith:(NSObject *)json;

@end
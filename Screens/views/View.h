#import <Foundation/Foundation.h>

@class ViewSpec, ScreenManager;


@interface View : UIView
@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) ScreenManager *screenManager;
@property(nonatomic, strong) UIImageView *backgroundImage;

- (id)initWith:(ViewSpec *)spec manager:(ScreenManager *)manager;

- (View *)subview:(NSString *)id;

- (UIView *)viewContainer;

@end
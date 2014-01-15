#import <Foundation/Foundation.h>


typedef BOOL (^ActionListener)(NSString* action, NSString *param);

@interface ScreenManager : NSObject

@property(nonatomic, strong) UIViewController *viewController;

- (id)initWith:(UIViewController *)viewController;

- (void)navigate:(NSString *)target;

- (void)back;

- (void)home;

-(void)register:(ActionListener)actionListener;

@end
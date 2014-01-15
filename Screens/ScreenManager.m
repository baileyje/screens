#import "ScreenManager.h"
#import "View.h"
#import "ScreenSpecsParser.h"
#import "ScreenSpec.h"

@interface ScreenManager ()
@property(nonatomic, strong) NSDictionary *screens;
@property(nonatomic, strong) NSArray *screenStack;
@property(nonatomic, strong) NSArray *actionListeners;
@end


@implementation ScreenManager

@synthesize screens, viewController, screenStack, actionListeners;

- (id)initWith:(UIViewController *)_viewController {
    self = [super init];
    self.viewController = _viewController;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"screens" withExtension:@"json"];
    NSArray *screenSpecs = [ScreenSpecsParser parse:url];
    NSMutableDictionary *screenMap = [NSMutableDictionary dictionary];
    for (ScreenSpec *screenSpec in screenSpecs) {
        [screenMap setObject:screenSpec forKey:screenSpec.name];
    }
    self.screens = screenMap;
    screenStack = [NSArray array];
    return self;
}

- (void)navigate:(NSString *)target {
    NSString *action = target;
    NSString *param = nil;
    NSRange match = [target rangeOfString:@":"];
    if(match.location != NSNotFound) {
        action = [target substringWithRange: NSMakeRange (0, match.location)];
        param = [target substringWithRange: NSMakeRange (match.location+match.length,(target.length-match.location)-match.length)];
    }

    if(actionListeners) {
        for(ActionListener listener in actionListeners) {
            if(!listener(action, param)) {
                return;
            }
        }
    }

    if ([action isEqualToString:@"screen"]) {
        ScreenSpec *spec = [self.screens objectForKey:param];
        if (!spec) return;
        View *current = [screenStack lastObject];
        [current removeFromSuperview];
        View *screenView = [[View alloc] initWith:spec manager:self];
        self.screenStack = [screenStack arrayByAddingObject:screenView];
        [self.viewController.view addSubview:screenView];
    } else if ([action isEqualToString:@"show"] || [action isEqualToString:@"hide"] || [action isEqualToString:@"toggle"]) {
        View *current = [screenStack lastObject];
        View *subview = [current subview:param];
        if ([action isEqualToString:@"toggle"]) {
            subview.hidden = !subview.hidden;
        } else {
            subview.hidden = [action isEqualToString:@"hide"];
        }
    } else if ([target isEqualToString:@"back"]) {
        return [self back];
    } else if ([target isEqualToString:@"home"]) {
        return [self home];
    }
}

- (void)back {
    if (screenStack.count <= 1) return;
    View *current = [screenStack lastObject];
    [current removeFromSuperview];
    self.screenStack = [screenStack subarrayWithRange:NSMakeRange(0, screenStack.count - 1)];
    View *prevView = [screenStack lastObject];
    [self.viewController.view addSubview:prevView];
}

- (void)home {
    View *current = [screenStack lastObject];
    [current removeFromSuperview];
    self.screenStack = [screenStack subarrayWithRange:NSMakeRange(0, 1)];
    View *firstView = [screenStack objectAtIndex:0];
    [self.viewController.view addSubview:firstView];
}

-(void)register:(ActionListener)actionListener {
    if(!actionListeners) {
        actionListeners = [NSArray arrayWithObject:actionListener];
    } else {
        actionListeners = [actionListeners arrayByAddingObject:actionListener];
    }
}

@end
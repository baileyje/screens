#import "FormView.h"
#import "ViewSpec.h"
#import "ScreenManager.h"
#import "TextFieldView.h"


@interface FormView () <UITextFieldDelegate>
@property(nonatomic, strong) UITextField *activeField;
@end

@implementation FormView

@synthesize activeField, activeTextFieldCallback;

- (id)initWith:(ViewSpec *)spec manager:(ScreenManager *)manager {
    self = [super initWith:spec manager:manager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.window];

    int tag = 0;
    for (View *subview in self.scrollView.subviews) {
        if ([subview isKindOfClass:TextFieldView.class]) {
            TextFieldView *textField = (TextFieldView *) subview;
            textField.textField.delegate = self;
            textField.textField.tag = tag++;
        }
    }

    return self;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    float screenHeight = -1;
    float keyboardHeight = -1;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        screenHeight = self.window.screen.bounds.size.width;
        keyboardHeight = keyboardSize.width;
    } else {
        screenHeight = self.window.screen.bounds.size.height;
        keyboardHeight = keyboardSize.height;
    }

    CGPoint absoluteOrigin = [[self.window.subviews objectAtIndex:0] convertPoint:CGPointZero fromView:self];
    float keyboardOffset = screenHeight - keyboardHeight;
    float overlapOffset = (keyboardOffset - absoluteOrigin.y);
    float coverage = self.bounds.size.height - overlapOffset;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, coverage, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;

    CGRect aRect = self.scrollView.frame;
    aRect.size.height -= coverage;

    if (!CGRectContainsPoint(aRect, activeField.superview.frame.origin)) {
        float fieldOffset = activeField.superview.frame.origin.y + activeField.superview.frame.size.height + 5.0;
        float scrollOffset = fieldOffset - overlapOffset;
        CGPoint scrollPoint = CGPointMake(0.0, scrollOffset);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}


- (void)keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeField = textField;
    if (activeTextFieldCallback) {
        activeTextFieldCallback((TextFieldView *) self.activeField.superview);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeField = nil;
    if (activeTextFieldCallback) {
        activeTextFieldCallback(nil);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UITextField *nextTextField = (UITextField *) [self viewWithTag:textField.tag + 1];
    if (nextTextField) {
        [nextTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

@end
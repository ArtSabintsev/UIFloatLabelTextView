//
//  UIFloatLabelTextView.m
//  UIFloatLabelSampleApp
//
//  Created by Arthur Sabintsev on 4/7/14.
//  Copyright (c) 2014 Arthur Ariel Sabintsev. All rights reserved.
//

#define UI_FLOAT_LABEL_VERTICAL_INSET_OFFSET    8.0f

#import "UIFloatLabelTextView.h"

@interface UIFloatLabelTextView ()

@property (nonatomic, strong) UIColor *storedTextColor;
@property (nonatomic, copy) NSString *storedText;
@property (nonatomic, strong) UIButton *clearTextFieldButton;
@property (nonatomic, assign) CGFloat xOrigin;
@property (nonatomic, assign) CGFloat horizontalPadding;

@end

@implementation UIFloatLabelTextView

#pragma mark - Initialization
- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}


#pragma mark - Breakdown
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:nil];
    
    [self setupMenuController];
}

#pragma mark - Setup
- (void)setup
{
    // Build textField
    [self setupTextView];
    
    // Build floatLabel
    [self setupFloatLabel];
    
    // Enable default UIMenuController options
    [self setupMenuController];
    
    // Add listeners to observe textView changes
    [self setupNotifications];
}

- (void)setupTextView
{
    // TextView Padding
    _horizontalPadding = 5.0f;
    self.contentInset = UIEdgeInsetsMake(UI_FLOAT_LABEL_VERTICAL_INSET_OFFSET,
                                         0.0f,
                                         0.0f,
                                         0.0f);
    
    // Text Alignment
    [self setTextAlignment:NSTextAlignmentLeft];
    
    // Text Color
    _storedTextColor = [UIColor blackColor];
    
    // Placeholder Color
    _placeholderTextColor = [UIColor lightGrayColor];
}

- (void)setupFloatLabel
{
    // floatLabel
    _floatLabel = [UILabel new];
    _floatLabel.textColor = [UIColor blackColor];
    _floatLabel.textAlignment = NSTextAlignmentLeft;
    _floatLabel.font =[UIFont boldSystemFontOfSize:12.0f];
    _floatLabel.alpha = 0.0f;
    [_floatLabel setCenter:CGPointMake(_xOrigin, 0.0f)];
    [self addSubview:_floatLabel];
    // colors
    _floatLabelPassiveColor = [UIColor lightGrayColor];
    _floatLabelActiveColor = [UIColor blueColor];
    
    // animationDuration
    _floatLabelAnimationDuration = @0.25;
}

- (void)setupMenuController
{
    _pastingEnabled = @YES;
    _copyingEnabled = @YES;
    _cuttingEnabled = @YES;
    _selectEnabled = @YES;
    _selectAllEnabled = @YES;
}

- (void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange:)
                                                 name:UITextViewTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidBeginEditing:)
                                                 name:UITextViewTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidEndEditing:)
                                                 name:UITextViewTextDidEndEditingNotification object:nil];
}

#pragma mark - Animation
- (void)toggleFloatLabel:(UIFloatLabelAnimationType)animationType
{
    // Placeholder
    _placeholder = (animationType == UIFloatLabelAnimationTypeShow) ? @"" : [_floatLabel text];
    
    // Reference textAlignment to reset origin of textView and floatLabel
    [self updateTextAlignment];
    
    // Common animation parameters
    UIViewAnimationOptions easingOptions = (animationType == UIFloatLabelAnimationTypeShow) ? UIViewAnimationOptionCurveEaseOut : UIViewAnimationOptionCurveEaseIn;
    UIViewAnimationOptions combinedOptions = UIViewAnimationOptionBeginFromCurrentState | easingOptions;
    void (^animationBlock)(void) = ^{
        [self toggleFloatLabelProperties:animationType];
    };
    
    // Toggle floatLabel visibility via UIView animation
    [UIView animateWithDuration:[_floatLabelAnimationDuration floatValue]
                          delay:0.0f
                        options:combinedOptions
                     animations:animationBlock
                     completion:nil];
    
}

#pragma mark - Helpers
- (void)toggleFloatLabelProperties:(UIFloatLabelAnimationType)animationType
{
    _floatLabel.alpha = (animationType == UIFloatLabelAnimationTypeShow) ? 1.0f : 0.0f;
    CGFloat yOrigin = (animationType == UIFloatLabelAnimationTypeShow) ? -UI_FLOAT_LABEL_VERTICAL_INSET_OFFSET : 0.0f;
    _floatLabel.frame = CGRectMake(_xOrigin,
                                   yOrigin,
                                   CGRectGetWidth([_floatLabel frame]),
                                   CGRectGetHeight([_floatLabel frame]));
}

- (void)updateRectForTextFieldGeneratedViaAutoLayout
{
    // Do not shift the frame if textField is pre-populated
    if (![self.text length]) {
        _floatLabel.frame = CGRectMake(_xOrigin,
                                       0.0f,
                                       CGRectGetWidth([_floatLabel frame]),
                                       CGRectGetHeight([_floatLabel frame]));
    }
}

#pragma mark - Notifications
- (void)textDidBeginEditing:(NSNotification *)notification
{
    if ([self.text isEqualToString:_placeholder]) {
        self.text = nil;
        self.textColor = _storedTextColor;
    }
}

- (void)textDidEndEditing:(NSNotification *)notification
{
    if (![self.text length]) {
        self.text = [self placeholder];
        self.textColor = [self placeholderTextColor];
    }
}

- (void)textDidChange:(NSNotification *)notification
{
    if ([self.text length]) {
        
        _storedText = [self text];
        
        if (![_floatLabel alpha]) {
            [self toggleFloatLabel:UIFloatLabelAnimationTypeShow];
        }
        
    } else {
        if ([_floatLabel alpha]) {
            [self toggleFloatLabel:UIFloatLabelAnimationTypeHide];
        }
        
        _storedText = @"";
    }
}

#pragma mark - UITextView (Override)
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    // When textField is pre-populated, show non-animated version of floatLabel
    if ([text length] && !_storedText && ![text isEqualToString:_placeholder]) {
        [self toggleFloatLabelProperties:UIFloatLabelAnimationTypeShow];
        _floatLabel.textColor = _floatLabelPassiveColor;
        self.textColor = _storedTextColor;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    if (!_storedTextColor) {
         _storedTextColor = [self textColor];
    }
}

- (void)updateTextAlignment
{
    NSTextAlignment textAlignment = [self textAlignment];
    _floatLabel.textAlignment = textAlignment;
    
    switch (textAlignment) {
        case NSTextAlignmentRight: {
            _xOrigin = CGRectGetWidth([self frame]) - CGRectGetWidth([_floatLabel frame]) - _horizontalPadding;
        } break;
            
        case NSTextAlignmentCenter: {
            _xOrigin = CGRectGetWidth([self frame])/2.0f - CGRectGetWidth([_floatLabel frame])/2.0f;
        } break;
            
        default: { // NSTextAlignmentLeft, NSTextAlignmentJustified, NSTextAlignmentNatural
            _xOrigin = _horizontalPadding;
        } break;
    }
}

#pragma mark - UIView (Override)
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateTextAlignment];
     
    if (![self isFirstResponder] && ![self.text length]) {
        [self toggleFloatLabelProperties:UIFloatLabelAnimationTypeHide];
    }
}

#pragma mark - UIResponder (Override)
-(BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];

    _floatLabel.textColor = _floatLabelActiveColor;
    _storedText = [self text];

    [self updateRectForTextFieldGeneratedViaAutoLayout];
    
    return YES;
}

- (BOOL)resignFirstResponder
{
    if ([_floatLabel.text length]) {
        _floatLabel.textColor = _floatLabelPassiveColor;
    }
    
    [super resignFirstResponder];
    
    return YES;
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:)) { // Toggle Pasting
        return ([_pastingEnabled boolValue]) ? YES : NO;
    } else if (action == @selector(copy:)) { // Toggle Copying
        return ([_copyingEnabled boolValue]) ? YES : NO;
    } else if (action == @selector(cut:)) { // Toggle Cutting
        return ([_cuttingEnabled boolValue]) ? YES : NO;
    } else if (action == @selector(select:)) { // Toggle Select
        return ([_selectEnabled boolValue]) ? YES : NO;
    } else if (action == @selector(selectAll:)) { // Toggle Select All
        return ([_selectAllEnabled boolValue]) ? YES : NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - Custom Synthesizers
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
 
    _floatLabel.text = _placeholder;
    if (![self.text length]) {
        self.text = _placeholder;
        self.textColor = _placeholderTextColor;
    }
    
    [_floatLabel sizeToFit];
}

@end

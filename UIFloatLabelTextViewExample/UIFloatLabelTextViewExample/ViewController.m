//
//  ViewController.m
//  UIFloatLabelSampleApp
//
//  Created by Arthur Sabintsev on 3/13/14.
//  Copyright (c) 2014 Arthur Ariel Sabintsev. All rights reserved.
//

#import "ViewController.h"
#import "UIFloatLabelTextView.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIFloatLabelTextView Example";
    
    [self setupTextView];
}

#pragma mark - View Creation
- (void)setupTextView
{
    // iOS 7 misaligned text bugfix (http://stackoverflow.com/a/19706526/814861)
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIFloatLabelTextView *textView = [UIFloatLabelTextView new];
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    textView.placeholder = @"Placeholder text for TextView1";
    textView.floatLabelActiveColor = [UIColor orangeColor];
    textView.floatLabelPassiveColor = [UIColor lightGrayColor];
    textView.textAlignment = NSTextAlignmentRight;
    textView.layer.borderColor = [[UIColor blackColor] CGColor];
    textView.font = [UIFont systemFontOfSize:19.0f];
    textView.floatLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:textView];

    
    // Horizontal
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textView]-10-|"
                                                                      options:NSLayoutFormatAlignAllBaseline
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(textView)]];
    
    // Vertical
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[textView(100)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(textView)]];
    
    
    UIFloatLabelTextView *textView2 = [UIFloatLabelTextView new];
    [textView2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    textView2.placeholder = @"Placeholder text for TextView2";
    textView2.floatLabelActiveColor = [UIColor orangeColor];
    textView2.floatLabelPassiveColor = [UIColor lightGrayColor];
    textView2.layer.borderColor = [[UIColor blackColor] CGColor];
    textView2.font = [UIFont systemFontOfSize:19.0f];
    textView2.floatLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:textView2];
    
    
    // Horizontal
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textView2]-10-|"
                                                                      options:NSLayoutFormatAlignAllBaseline
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(textView2)]];
    
    // Vertical
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[textView2(100)]-200-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(textView, textView2)]];
    
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isKindOfClass:[UITextView class]]) {
        [touch.view endEditing:YES];
    }
}

@end

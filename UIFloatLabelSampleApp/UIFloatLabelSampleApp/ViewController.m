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
    textView.placeholder = @"This is your placeholder text";
    textView.floatLabelActiveColor = [UIColor orangeColor];
    textView.floatLabelPassiveColor = [UIColor lightGrayColor];
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
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[textView(200)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(textView)]];
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}

@end

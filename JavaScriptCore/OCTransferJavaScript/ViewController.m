//
//  ViewController.m
//  OCTransferJavaScript
//
//  Created by chenjiangchuan on 16/8/10.
//  Copyright © 2016年 JC'Chan. All rights reserved.
//
//  Objective-C调用JavaScript的函数，并把返回值打印出来
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

/** JSContext */
@property (strong, nonatomic) JSContext *context;
/** UITextField */
@property (strong, nonatomic) UITextField *textField;
/** UIButton */
@property (strong, nonatomic) UIButton *button;

@end

@implementation ViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.button];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.textField.frame = (CGRect){{100, 100}, {80, 30}};
    self.button.frame = (CGRect){{120, 150}, {80, 80}};
}

#pragma mark - Event Response

- (void)clickButton {
    [self setupJavaScript];
}

#pragma mark - Private Methods

- (void)setupJavaScript {

    // 获取index.js文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"js"];

    NSString *scriptString = [NSString
                              stringWithContentsOfFile:filePath
                              encoding:NSUTF8StringEncoding
                              error:nil];

    self.context = [[JSContext alloc] init];
    
    [self.context evaluateScript:scriptString];

    // 调用JS的函数
    [self setupJSFunction];
}

- (void)setupJSFunction {
    // 获取textField输入，并转成NSNumber类型
    NSNumber *inputNumber = [NSNumber
                             numberWithInteger:[self.textField.text integerValue]];

    // 创建JCValue, factorial为JS函数的名字
    JSValue *function = [self.context objectForKeyedSubscript:@"factorial"];

    // 向函数中传入参数
    JSValue *result = [function callWithArguments:@[inputNumber]];

    // 返回的结果
    NSNumber *number = [result toNumber];

    NSLog(@"number = %@", number);
}

#pragma mark - Getters and Setters

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField setBackgroundColor:[UIColor redColor]];
    }
    return _textField;
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"计算结果" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end

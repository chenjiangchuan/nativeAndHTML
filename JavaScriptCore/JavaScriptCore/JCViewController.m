//
//  JCViewController.m
//  JavaScriptCore
//
//  Created by chenjiangchuan on 16/8/10.
//  Copyright © 2016年 JC'Chan. All rights reserved.
//

#import "JCViewController.h"

@interface JCViewController () 

/** UIWebView */
@property (strong, nonatomic) UIWebView *webView;
/** JSContext */
@property (strong, nonatomic) JSContext *context;

@end

@implementation JCViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.webView.frame = self.view.bounds;
}

#pragma mark - Private Methods

/**
 *  获取Html文件
 */
- (NSString *)getHtmlFile {
    return [[NSBundle mainBundle] pathForResource:@"login/index" ofType:@"html"];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    // 方法一：不推荐使用，会出现循环引用，即使使用weak self也不行，
    // 只能设置其他的类。
    self.context[@"native"] = self;

    // 方式二：使用block，不会出现循环引用的问题,推荐使用.
    // 但在block内部要注意，不要出现循环引用
    self.context[@"log"] = ^(NSString *str) {
        NSLog(@"%@", str);
    };
}

#pragma mark - WebViewJSExport

- (void)handleFactorialCalculateWithString:(NSString *)string {
    NSLog(@"%@", string);
}

- (void)pushToNextViewControllerWithTitle:(NSString *)title {
    NSLog(@"%@", title);
}

#pragma mark - Getters and Setters

- (JSContext *)context {
    if (_context == nil) {
        _context = [[JSContext alloc] init];
    }
    return _context;
}

- (UIWebView *)webView {
    if (_webView == nil) {

        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", [self getHtmlFile]]];

        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        _webView = [[UIWebView alloc] init];
        [_webView loadRequest:request];

        _webView.delegate = self;
    }
    return _webView;
}

@end

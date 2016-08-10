//
//  ViewController.m
//  Before-iOS7-JSTONative
//
//  Created by chenjiangchuan on 16/8/10.
//  Copyright © 2016年 JC'Chan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupWebView];
}

#pragma mark - Life Circle

- (void)setupWebView {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"JSToNative" ofType:@"html"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", filePath]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    self.webView.delegate = self;
    [self.webView loadRequest:request];
}

/**
 *  html调用OC中的方法
 */
- (void)openCamera {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {

    // URL转String
    NSString *requestString = request.URL.absoluteString; // native://openCamera

    // 解析字符串
    NSRange range = [requestString rangeOfString:@"native://"];

    // 不是事先定义的协议头，直接return
    if (range.location == NSNotFound) return YES;

    NSString *method = [requestString substringFromIndex:range.location + range.length];

    // 动态调用openCamera方法
    [self performSelector:NSSelectorFromString(method)];

    return YES;
}

@end

//
//  JCViewController.m
//  Before-iOS7-NativeTOJS
//
//  Created by chenjiangchuan on 16/8/10.
//  Copyright © 2016年 JC'Chan. All rights reserved.
//

#import "JCViewController.h"

@interface JCViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
/** UIActivityIndicatorView */
@property (strong, nonatomic) UIActivityIndicatorView *activity;

@end

@implementation JCViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupWebView];
}

#pragma mark - Private Methods

- (void)setupWebView {
    NSURL *url = [NSURL URLWithString:@"http://m.t.17186.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate = self;

    // 添加菊花
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity startAnimating];
    activity.center = self.view.center;
    self.activity = activity;
    [self.webView addSubview:activity];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    // 对JS进行操作

    // 删除顶部栏
    // DOM操作，通过class获取标签
    NSString *deleteHeadAD = @"document.getElementById('header').remove();";

    [webView stringByEvaluatingJavaScriptFromString:deleteHeadAD];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activity stopAnimating];
        self.webView.scrollView.hidden = NO;
    });
}

@end

//
//  ViewController.m
//  JavaScriptCore
//
//  Created by chenjiangchuan on 16/8/10.
//  Copyright © 2016年 JC'Chan. All rights reserved.
//

#import "ViewController.h"
#import "JCViewController.h"

@interface ViewController ()

/** UIButton */
@property (strong, nonatomic) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.btn];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.btn.frame = (CGRect){{50, 50}, {200, 200}};
}

- (void)clickButton {
    JCViewController *vc = [[JCViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (UIButton *)btn {
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"点我" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end

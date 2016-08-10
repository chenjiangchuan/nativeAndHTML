//
//  JCViewController.h
//  JavaScriptCore
//
//  Created by chenjiangchuan on 16/8/10.
//  Copyright © 2016年 JC'Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol WebViewJSExport <JSExport>

JSExportAs
(functionNameForJS /** JavaScript function 的别名 */,

 - (void)handleFactorialCalculateWithString:(NSString *)string

 );

- (void)pushToNextViewControllerWithTitle:(NSString *)title;

@end

@interface JCViewController : UIViewController <UIWebViewDelegate, WebViewJSExport>

@end

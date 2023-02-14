//
//  TFYWKWebView.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class TFYWKWebView;

NS_ASSUME_NONNULL_BEGIN

@protocol TFYWebViewDelegate <NSObject>

@optional
// 网页加载进度
- (void)webView:(TFYWKWebView *)webView estimatedProgress:(CGFloat)progress;
// 网页标题更新
- (void)webView:(TFYWKWebView *)webView didUpdateTitle:(NSString *)title;
// 网页开始加载
- (BOOL)webView:(TFYWKWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType;
// 网页开始加载
- (void)webViewDidStartLoad:(TFYWKWebView *)webView;
// 网页完成加载
- (void)webViewDidFinishLoad:(TFYWKWebView *)webView;
// 网页加载出错
- (void)webView:(TFYWKWebView *)webView didFailLoadWithError:(NSError *)error;

@end

@interface TFYWKWebView : WKWebView<WKNavigationDelegate>

// 代理
@property (nonatomic,assign) id<TFYWebViewDelegate> delegate;
// 是否显示进度条[默认 NO]
@property (nonatomic,assign) BOOL displayProgressBar;

// 清缓存
- (void)clearCache;


@end

NS_ASSUME_NONNULL_END

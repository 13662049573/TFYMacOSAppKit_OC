//
//  TFYWKWebView.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import "TFYWKWebView.h"

@interface TFYWKWebView ()
@property (nonatomic, strong) NSProgressIndicator *progressBar;
@end

@implementation TFYWKWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 监听网页加载进度
        [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        // 监听网页标题变化
        [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark - setter
- (void)setDelegate:(id<TFYWebViewDelegate>)delegate
{
    _delegate = delegate;
    if (delegate) {
        self.navigationDelegate = self;
    }
}

- (void)setDisplayProgressBar:(BOOL)displayProgressBar
{
    _displayProgressBar = displayProgressBar;
    if (displayProgressBar) {
        _progressBar = [[NSProgressIndicator alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, 5.0f)];
        _progressBar.indeterminate = YES;
        _progressBar.bezeled = YES;
        _progressBar.controlSize = NSControlSizeSmall;
        _progressBar.style = NSProgressIndicatorStyleBar;
        _progressBar.displayedWhenStopped = YES;
        [self addSubview:_progressBar];
    }
}

#pragma mark - 清缓存
- (void)clearCache
{
    // 所有类型缓存[详见WKWebsiteDataRecord]
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    // 所有时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    // 移除
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                               modifiedSince:date
                                           completionHandler:^{
                                               
                                           }];
}

#pragma mark - 进度<KVO>
// 网页加载进度 || 网页标题
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"estimatedProgress"])
    {
        NSString *progressStr = [change objectForKey:NSKeyValueChangeNewKey];
        CGFloat progress = [progressStr doubleValue];
        if ([self.delegate respondsToSelector:@selector(webView:estimatedProgress:)]) {
            [self.delegate webView:self estimatedProgress:progress];
        }
        // 如果使用本类中的进度条，代理可不用!!!
        if (_progressBar) {
            _progressBar.doubleValue = progress;
            if (progress == 1.0) {
                _progressBar.doubleValue = 0;
            }
        }
    }
    if (object == self && [keyPath isEqualToString:@"title"])
    {
        NSString *title = [change objectForKey:NSKeyValueChangeNewKey];
        if ([self.delegate respondsToSelector:@selector(webView:didUpdateTitle:)] && title) {
            [self.delegate webView:self didUpdateTitle:title];
        }
    }
}

#pragma mark - 代理<WKNavigationDelegate>
// 网页开始加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    BOOL isAllow = YES;
    if ([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        isAllow = [self.delegate webView:self shouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    }
    if (isAllow) {
        decisionHandler(WKNavigationActionPolicyAllow);
    } else {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

// 网页开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self];
    }
}

// 网页完成加载
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.delegate webViewDidFinishLoad:self];
    }
}

// 网页加载出错
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate webView:self didFailLoadWithError:error];
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
    [self removeObserver:self forKeyPath:@"title"];
}


@end

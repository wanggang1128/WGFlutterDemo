//
//  WGFlutterIosWebView.m
//  Runner
//
//  Created by wanggang on 2019/8/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "WGFlutterIosWebView.h"
#import <WebKit/WebKit.h>


@interface WGFlutterIosWebView()<WKNavigationDelegate,WKUIDelegate>

//WGFlutterIosWebView 创建后的标识
@property (nonatomic, assign) NSInteger viewId;
@property (nonatomic, strong) WKWebView *wkWebView;

@end


@implementation WGFlutterIosWebView

-(instancetype)initWithWithFrame:(CGRect)frame
                  viewIdentifier:(NSInteger)viewId
                       arguments:(id _Nullable)args
                 binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger{
    
    self = [super init];
    if (self) {
        if (frame.size.width==0) {
            frame=CGRectMake(frame.origin.x, frame.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
        
        self.wkWebView =  [[WKWebView alloc] initWithFrame:frame];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        
        //接收 初始化参数
        NSDictionary *dic = args;
        NSString *content = dic[@"content"];
        if (content!=nil) {
            [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:content]]];
        }
        
        _viewId = viewId;
    }
    return self;
}

- (nonnull UIView *)view {
    return self.wkWebView;
}

@end

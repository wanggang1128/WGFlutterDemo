//
//  WGFlutterIosWebViewPlugin.m
//  Runner
//
//  Created by wanggang on 2019/8/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "WGFlutterIosWebViewPlugin.h"
#import "WGFlutterIosWebViewFactory.h"

@implementation WGFlutterIosWebViewPlugin

+(void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar{
    
    //注册插件
    //flutter_to_native_webView 为flutter 调用此  webview 的标识
    [registrar registerViewFactory:[[WGFlutterIosWebViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"flutter_to_native_webView"];
}

@end

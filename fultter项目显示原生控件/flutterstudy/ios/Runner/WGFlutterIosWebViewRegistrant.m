//
//  WGFlutterIosWebViewRegistrant.m
//  Runner
//
//  Created by wanggang on 2019/8/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "WGFlutterIosWebViewRegistrant.h"

@implementation WGFlutterIosWebViewRegistrant

+(void)registerWithRegistry:(NSObject<FlutterPluginRegistry> *)registry{
    //注册插件
    [WGFlutterIosWebViewPlugin registerWithRegistrar:[registry registrarForPlugin:@"WGFlutterIosWebViewPlugin"]];
}

@end

//
//  WGFlutterIosWebViewRegistrant.h
//  Runner
//
//  Created by wanggang on 2019/8/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "WGFlutterIosWebViewPlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGFlutterIosWebViewRegistrant : NSObject

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry;

@end

NS_ASSUME_NONNULL_END

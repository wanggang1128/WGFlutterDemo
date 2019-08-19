#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "WGFlutterIosWebViewRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    //flutter 中引用的插件通过些类来注册
    [GeneratedPluginRegistrant registerWithRegistry:self];
    //注册插件
    [WGFlutterIosWebViewRegistrant registerWithRegistry:self];
    
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

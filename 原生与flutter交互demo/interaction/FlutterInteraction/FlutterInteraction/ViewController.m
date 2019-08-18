//
//  ViewController.m
//  FlutterInteraction
//
//  Created by wanggang on 2019/8/14.
//  Copyright © 2019 wg. All rights reserved.
//



#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height


#import "ViewController.h"
#import <Flutter/Flutter.h>
//如果用到flutter插件时,导入下面头文件
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

#import "FirstViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"我是原生-ViewController页面";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 100, Screen_width-30, 30)];
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = UIColor.greenColor;
    [btn setTitle:@"调用flutter页面,flutter主动和iOS交互" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClicked{
    
    [self pushToFlutterView];
}

- (void)pushToFlutterView{
    
    FlutterViewController *flutterVC = [FlutterViewController new];
    [flutterVC setInitialRoute:@"myApp"];
    
    __weak __typeof(self) weakSelf = self;
    
    NSString *channelName = @"wg/native_get";
    
    //FlutterMethodChannel是flutter页面主动交互iOS页面
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:flutterVC];
    //flutter页面方法触发
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
        
        NSLog(@"---->call.method=%@ \n call.arguments = %@", call.method, call.arguments);
        
        // method和WKWebView里面JS交互很像
        // flutter点击事件执行后需要iOS做的事
        if ([call.method isEqualToString:@"iOSFlutter"]) {
            
            FirstViewController *firstVC = [[FirstViewController alloc] init];
            [weakSelf.navigationController pushViewController:firstVC animated:YES];
        }
        
        // flutter给iOS传的参数
        if ([call.method isEqualToString:@"iOSFlutter1"]) {
            
            NSDictionary *dic = call.arguments;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"flutter页面传过来的字典" message:[NSString stringWithFormat:@"%@",dic] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        //iOS给flutter返回值
        if ([call.method isEqualToString:@"iOSFlutter2"]) {
            if (result) {
                result(@"这是iOS返回给flutter的内容");
            }
        }
        
        if ([call.method isEqualToString:@"changeNavStatus"]) {
            NSString *arguments = call.arguments;
            if ([arguments containsString:@"show"]) {
                weakSelf.navigationController.navigationBarHidden = NO;
            }else{
                weakSelf.navigationController.navigationBarHidden = YES;
            }
        }
        
        if ([call.method isEqualToString:@"backToViewController"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    //原生iOS跳转到Flutter页面
    [self.navigationController pushViewController:flutterVC animated:YES];
}


@end

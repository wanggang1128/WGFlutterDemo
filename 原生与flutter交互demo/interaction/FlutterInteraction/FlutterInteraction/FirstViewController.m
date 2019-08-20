//
//  FirstViewController.m
//  FlutterInteraction
//
//  Created by wanggang on 2019/8/16.
//  Copyright © 2019 wg. All rights reserved.
//

#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height


#import "FirstViewController.h"
#import <Flutter/Flutter.h>


@interface FirstViewController ()<FlutterStreamHandler>

@property (nonatomic, copy) FlutterEventSink eventSink;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"我是原生FirstViewController页面";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, Screen_width, 30)];
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = UIColor.redColor;
    [btn setTitle:@"调用flutter页面-->iOS主动和flutter交互" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClicked{
    FlutterViewController *flutterVC = [FlutterViewController new];
//    flutterVC.navigationItem.title = @"标题";
    [flutterVC setInitialRoute:@"home"];
    
    NSString *eventChannelName = @"wg/native_post";
    NSString *methodChannelName = @"wg/native_get";
    
    /*---------FlutterEventChannel是IOS主动与flutter交互-----------*/
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:eventChannelName binaryMessenger:flutterVC];
    
    // 代理FlutterStreamHandler
    [eventChannel setStreamHandler:self];
    /*---------FlutterEventChannel是IOS主动与flutter交互-----------*/

    
    /*---------FlutterMethodChannel是flutter主动与IOS交互-----------*/
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:methodChannelName binaryMessenger:flutterVC];
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        if ([call.method isEqualToString:@"changeNavStatus"]) {
            NSString *arguments = call.arguments;
            if ([arguments containsString:@"show"]) {
                self.navigationController.navigationBarHidden = NO;
            }else{
                self.navigationController.navigationBarHidden = YES;
            }
        }
        
        if ([call.method isEqualToString:@"backToViewController"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    /*---------FlutterMethodChannel是flutter主动与IOS交互-----------*/
    
    [self.navigationController pushViewController:flutterVC animated:YES];
    
}

#pragma mark - <FlutterStreamHandler>
//这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
-(FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events{
    
    self.eventSink = events;
    // arguments flutter监听时,给native传送的参数
    if (self.eventSink) {
        self.eventSink(@"原生push到fluttet页面,传给flutter的值");
    }
    return nil;
}

// flutter不再接收
-(FlutterError *)onCancelWithArguments:(id)arguments{
    
    //
    self.eventSink = nil;
    return nil;
}



@end

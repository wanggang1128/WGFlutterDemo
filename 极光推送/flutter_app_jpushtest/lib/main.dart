import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String debugLab = '初始值';
  final JPush jPush = JPush();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.initPlatformState();
  }

  Future<void> initPlatformState() async {

    String plateFormVersion;


    jPush.setAlias('jg123456').then((map) {
      print('---->设置别名成功');
    });

    jPush.getRegistrationID().then((rid) {
      print('---->rid:${rid}');
    });

    jPush.setup(
      //公司账号
      //57c65a795726b2a99e732bac
      //个人账号
      //ffb598d1e96c3f06a51a9cdd
      appKey: '57c65a795726b2a99e732bac',
      channel: "developer-default",
      production: false,
      debug: true,
    );

    jPush.applyPushAuthority(
      NotificationSettingsIOS(sound: true, alert: true, badge: true)
    );


    try {

      jPush.addEventHandler(
        onReceiveNotification: (Map<String,dynamic>message) async {
          print('---->接收到推送:${message}');
          setState(() {
            debugLab = '接收到推送:${message}';
          });
        }
      );
    } on Exception {
      print("---->获取平台版本失败");
      plateFormVersion = '获取平台版本失败';
    }

    if (!mounted) return;

    setState(() {
      debugLab = plateFormVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '极光推送',
      home: Scaffold(
        appBar: AppBar(
          title: Text('极光推送测试'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('结果：${debugLab}'),
              FlatButton(
                child: Text('发送推送消息'),
                onPressed: () {
                  var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch+3000);
                  var localNotification = LocalNotification(
                    id: 001,
                    title: '这是一个标题',
                    buildId: 1,
                    content: '这是推送内容',
                    fireTime: fireDate,
                    subtitle: '这是一个副标题',
                  );

                  jPush.sendLocalNotification(localNotification).then((res) {
                    setState(() {
                      debugLab = res;
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter项目显示ios页面',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('flutter项目显示ios页面'),
        ),
        body: Container(
          height: ScreenUtil.screenHeightDp,
          child: UiKitView(
            //设置标识
            //这里设置的 viewType值与 ios 中插件注册的标识 一至
            // [registrar registerViewFactory:[[FlutterIosTextLabelFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.flutter_to_native_test_textview"];
            viewType: "flutter_to_native_webView",
            creationParams: {
              "content": "https://yaoxun.langtuojs.com/nc_mobile_patient/#/wechat?appointId=472&patientId=patientId_23&patientName=%5CU7f57%5CU4f0a&nurseId=nurseId_10820&nurseName=1%5CU53f2%5CU96c5%5CU6615&useType=2&chatMode=1&Access-Token=192EAC21DC8F442CA158704548C4CDB7",
//              'content':'https://www.jianshu.com/u/c9dfc3858121',
            },
            //参数的编码方式
            creationParamsCodec: const StandardMessageCodec(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
//引入下面这个，是为了调用window的defaultRouteName拿到route判断跳转哪个界面
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_module/flutter_first.dart';

void main() => runApp(_widgetForRoute(window.defaultRouteName));

//根据原生给的民资，确定显示那个界面
Widget _widgetForRoute(String route){
  switch (route){
    case 'myApp':
      return MyApp();
    case 'home':
      return FlutterFirst();
    default:
      return MyApp();
  }

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      routes: <String, WidgetBuilder>{
        "/home":(BuildContext context) => FlutterFirst(),
      },
      home: MyHomePage(title: '我是flutter-->MyHomePage页面',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  //创建一个给native的channel (类似iOS的通知）
  static const methodChannel = const MethodChannel('wg/native_get');

  //告诉ios，需要跳转到下一页了。ios自己跳,并传给ios一个字符串
  _iosPushToVC() async {
    //invokeMethod:两个参数Method:方法名（两端要统一），arguments：此方法名下需要传的参数
    await methodChannel.invokeMethod('iOSFlutter', '这是flutter传的字符串');
  }

  //传给ios一个map
  _iosGetMap() async {
    Map<String, dynamic> value = {"code": "200", "data":[1,2,3]};
    await methodChannel.invokeMapMethod('iOSFlutter1',value);
  }

  //拿到ios的返回值
  _getIosValue() async {
   dynamic result;
   try{
     result = await methodChannel.invokeMethod('iOSFlutter2');
   }on PlatformException{
     result = "error";
   }

   if(result is String){
     showModalBottomSheet(context: context, builder: (BuildContext context){
       return Container(
         child: Center(
           child: Text(result,style: TextStyle(color: Colors.brown), textAlign: TextAlign.center,),
         ),
         height: 40,
       );
     });
   }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //添加观察者
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if(state != AppLifecycleState.resumed){
      methodChannel.invokeMethod('changeNavStatus', 'didChangeAppLifecycleState:${state}-show');
    }else{
      methodChannel.invokeMethod('changeNavStatus', 'didChangeAppLifecycleState:${state}-hiden');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this); //销毁观察者
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
//        automaticallyImplyLeading: true,
        leading: Container(
          color: Colors.green,
          child: RaisedButton(
            onPressed: (){
              methodChannel.invokeMethod('backToViewController');
            },
            child: Icon(
              Icons.arrow_back,
//              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: _iosPushToVC,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.forward),
                    Text('跳转ios新界面，参数是字符串'),
                  ],
                ),
            ),
            InkWell(
              onTap: _iosGetMap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.forward),
                  Text('传参，参数是map'),
                ],
              )
            ),
            InkWell(
              onTap: _getIosValue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.forward),
                  Text('接收iOS返回的内容'),
                ],
              )
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

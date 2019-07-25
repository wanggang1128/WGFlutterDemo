import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget addressContainer = Container(
      // 此部分四周间隔一定距离
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              // 顶部对齐
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // 与下面文本问隔一定距离
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '测试地址',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  '浙江省杭州市滨江区',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.blue[400],
          ),
          Text(
            '66',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ],
      ),
    );

    // 构建按钮组中单个按钮参数为图标及文本
    Column buildButtonColumn(IconData icon, String label) {
      return Column(
        // 垂直方向居中对齐
        mainAxisAlignment: MainAxisAlignment.center,
        // 垂直方向大小最小化
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 上面图标部分
          Icon(
            icon,
            color: Colors.lightGreen[600],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Colors.lightGreen[600],
              ),
            ),
          ),
        ],
      );
    }

    // 按钮组部分
    Widget buttonsContainer = Container(
      // 容器横向布局
      child: Row(
        // 水平方向均匀排列每个元素
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, '电话'),
          buildButtonColumn(Icons.near_me, '导航'),
          buildButtonColumn(Icons.share, '分享'),
        ],
      ),
    );

    // 风景区介绍文本部分
    Widget textContainer = Container(
      padding: const EdgeInsets.all(15.0),
      // 文本块一定是用'''来引用起来
      child: Text(
        '''
        1、先执行11111
        2、遇到sync，同步任务，不会开启子线程，而且会阻塞当前线程，所以会执行2222
        3、遇到aync，异步任务会开启子线程，不会阻塞当前线程，所以 执行一下3333，但是不需要3333这个异步任务执行完（不会阻塞当前线程） 就可以执行4444
        4、执行完4444后，因为3333延迟2秒，所以会执行5555（如果不延迟2秒的话，可能会先执行3333也可能会先执行5555）
        5、2秒后执行3333
        1、在串行队列中，任务顺序执行，必修等一个任务完成才能执行下一个任务，代码中sync包含两个任务：block1（2222，3333，4444）和block2（3333）
        2、首先执行1111
        3、遇到sync：同步任务，且在串行队列中有两个任务，顺序为block1和block2，所以要先执行完block1才能执行block2，所以先执行2222
        4、遇到block1中async：异步任务，开启一个线程，不会阻塞当前线程，所以执行sleep和4444，因为3333是在block2中，所以会要把sleep和4444执行完（谨记sleep和4444在block1中），才会执行block2中的3333
        5、两个任务都执行完后，执行sleep和5555
        1、先执行1111
        2、遇到aync：异步任务，开启子线程，不会阻塞当前线程，所以执行5555
        3、在aync中先执行2222
        4、遇到sync：同步任务，不会开启新的子线程，且阻塞当前线程（2步骤中开启的子线程），又因为任务block1和block2在串行队列中，所以必须要等到任务block1（4444）执行完才能执行任务block2（3333），综合刚才说的block2（3333）阻塞这个子线程(即必须等到block2（3333）完成才能继续执行block1中的（4444）），进而造成死锁。
        dispatch_apply类似一个for循环，会在指定的队列中中运行block任务n次，如果队列是并发队列，则会并发执行block任务。
        dispatch_apply在串行队列中按照顺序执行，完全没有意义。在并发队列中创建了N个任务，但并非所有任务都开辟线程，也有在主线程中完成的。输出end,因为dispatch_apply函数会等待所有的处理结束,才会向下执行。
        ''',
        softWrap: true,
        style: TextStyle(fontSize: 15),
      ),
    );

    return new MaterialApp(
      title: '综合布局代码',
      // 自定义主题，主体颜色为绿色风格
      theme: new ThemeData(
        // 应用程序整体主题的亮度
        brightness: Brightness.light,
        //App 主要部分的背景色
        primaryColor: Colors.lightGreen[600],
        // 前景色(文本、按钮等)
        accentColor: Colors.orange[600],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '综合布局代码',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Image.asset(
              'images/wudang.jpeg',
              width: 600,
              height: 240,
              // 图片填充整个父容器
              fit: BoxFit.cover,
            ),
            addressContainer,
            buttonsContainer,
            textContainer,
          ],
        ),
      ),
    );
  }
}

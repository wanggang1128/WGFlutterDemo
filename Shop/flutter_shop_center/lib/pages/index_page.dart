//纸墨设计风格
import 'package:flutter/material.dart';
//iOS比较有好的设计风格
import 'package:flutter/cupertino.dart';

import 'home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provide/provide.dart';
import '../provide/currentIndex.dart';


class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.home),
        title:Text('首页')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.search),
        title:Text('分类')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.shopping_cart),
        title:Text('购物车')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.profile_circled),
        title:Text('会员中心')
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Provide<CurrentIndexProvide>(

        builder: (context,child,val){
          int currentIndex= Provide.value<CurrentIndexProvide>(context).currentIndex;
          return Scaffold(
            backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
            bottomNavigationBar: BottomNavigationBar(
              type:BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items:bottomTabs,
              onTap: (index){
                Provide.value<CurrentIndexProvide>(context).changeIndex(index);
              },
            ),
            body: IndexedStack(
                index: currentIndex,
                children: tabBodies
            ),
          );
        }
    );

  }
}

//class IndexPage extends StatefulWidget {
//  @override
//  _IndexPageState createState() => _IndexPageState();
//}
//
//class _IndexPageState extends State<IndexPage> {
//
//  //底部导航栏数据
//  final List<BottomNavigationBarItem> bottomTabs = [
//
//    BottomNavigationBarItem(
//      icon: Icon(CupertinoIcons.home),
//      title: Text('首页')
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.home),
//        title: Text('分类')
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.home),
//        title: Text('购物车')
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.home),
//        title: Text('个人中心')
//    ),
//  ];
//
//  final List<Widget> pageList = [
//    HomePage(),
//    CategoryPage(),
//    CartPage(),
//    MemberPage()
//  ];
//
//  int currentIndex = 0;
//  Widget currentPage;
//
//  @override
//  void initState() {
//    super.initState();
//
//    currentPage = pageList[currentIndex];
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//
//    return Scaffold(
//      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//      bottomNavigationBar: BottomNavigationBar(
//        items: bottomTabs,
//        type: BottomNavigationBarType.fixed,
//        currentIndex: currentIndex,
//        onTap: (index){
//          setState(() {
//            currentIndex = index;
//            currentPage = pageList[currentIndex];
//          });
//        },
//      ),
//      body: IndexedStack(
//        index: currentIndex,
//        children: pageList,
//      ) ,
//    );
//  }
//}


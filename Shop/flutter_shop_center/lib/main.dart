import 'package:flutter/material.dart';

import './pages/index_page.dart';

import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/child_category_goods_list.dart';

void main(){
  var counter = Counter();
  var childCategory = ChildCategory();
  var childCategoryGoodsListProvide = ChildCategoryGoodsListProvide();
  var provides = Providers();
  provides
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<ChildCategoryGoodsListProvide>.value(childCategoryGoodsListProvide));

  runApp(ProviderNode(child: MyApp(), providers: provides));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //这里最外层添加一个容器是为了后期方便维护
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}

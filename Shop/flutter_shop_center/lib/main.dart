import 'package:flutter/material.dart';

import './pages/index_page.dart';

import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/child_category_goods_list.dart';
import './provide/details_info.dart';

import 'package:fluro/fluro.dart';
import './routers/router.dart';
import './routers/application.dart';

void main(){
  //状态管理配置
  var counter = Counter();
  var childCategory = ChildCategory();
  var childCategoryGoodsListProvide = ChildCategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var provides = Providers();
  provides
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<ChildCategoryGoodsListProvide>.value(childCategoryGoodsListProvide));

  runApp(ProviderNode(child: MyApp(), providers: provides));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //把路由注册到顶层
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    //这里最外层添加一个容器是为了后期方便维护
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(
          primarySwatch: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}

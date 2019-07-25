import 'package:flutter/material.dart';

class Product{

  String title;
  String description;

  //构造方法,其中this.title代表self.title = title
  Product(this.title, this.description);
}

main(){
  runApp(MaterialApp(
    title: '导航跳转和数据传递',
    home: ProductPage(

      products:List.generate(30, (i)=>Product('商品 $i', '这是商品描述，编号为 $i'))
    )
  ));
}

class ProductPage extends StatelessWidget{

  final List<Product> products;
  ProductPage({Key key, @required this.products}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        title: Text('商品列表'),
      ),
      body: Center(
        child: ListView.builder(
            //cell个数
            itemCount: products.length,
            itemBuilder: (context, index) {
              //每一个cell
              return ListTile(
                  title: Text('${products[index].title}'),
                  subtitle: Text('${products[index].description}'),
                //点击事件
                onTap: (){
                  _tapMethod(context, index);
                },
              );
            }
        ),
      ),
    );
  }

  //异步处理
  _tapMethod(BuildContext context, int index) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=>ProductDetailPage(
              product: products[index])
        )
    );
    if (null != result){
      //第一页面提示返回过来的值
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));
    }
  }
}


class ProductDetailPage extends StatelessWidget{

  final Product product;
  ProductDetailPage({Key key, @required this.product}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        title: Text('${product.title}')
      ),
      body: Column(
        children: <Widget>[
          Center(child: Text('${product.description}', style: TextStyle(fontSize: 25))),
          RaisedButton(
              onPressed: (){
                Navigator.pop(context, product.description);
              },
            child: Text('返回'),
            color: Colors.purple
          )
        ],
      ),
    );
  }
}
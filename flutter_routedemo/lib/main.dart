import 'package:flutter/material.dart';

class Product{

  String title;
  String description;

  Product(this.title, this.description);
}

main(){
  runApp(MaterialApp(
    title: '导航跳转和数据传递',
    home: PruductPage(

      products:List.generate(30, (i)=>Product('商品 $i', '这是商品描述，编号为 $i'))
    )
  ));
}

class PruductPage extends StatelessWidget{

  final List<Product> products;
  PruductPage({Key key, @required this.products}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        title: Text('商品列表'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text('${products[index].title}'),
                  subtitle: Text('${products[index].description}'),
                onTap: (){

                  _tapMethod(context, index);
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PruductDetailPage(product: products[index],)));
                },
              );
            }
        ),
      ),
    );
  }

  _tapMethod(BuildContext context, int index) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=>PruductDetailPage(
              product: products[index])
        )
    );
    if (null != result){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));
    }
  }
}


class PruductDetailPage extends StatelessWidget{

  final Product product;
  PruductDetailPage({Key key, @required this.product}):super(key:key);

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
import 'package:flutter/material.dart';

class WrapView extends StatefulWidget {
  @override
  _WrapViewState createState() => _WrapViewState();
}

class _WrapViewState extends State<WrapView> {

  List<Widget> dataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataList = List()..add(addBtnMethod());
  }

  Widget addBtnMethod(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        color: Colors.grey,
        child: IconButton(
            icon: Icon(Icons.add,color: Colors.white,),
            onPressed: (){
              if(dataList.length<9){
                setState(() {
                  dataList.insert(dataList.length-1, photoMethod(dataList.length));
                });
              }
            }
        ),
      ),
    );
  }

  Widget photoMethod(int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.purple,
        width: 80.0,
        height: 80.0,
        child: Center(
          child: Text('照片$index',style: TextStyle(fontSize: 25),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('图片选择'),
      ),
      body: Center(
        child: Opacity(
          opacity: 0.8,
          child: Container(
            height: height/2,
            width: width,
            color: Colors.grey[400],
            child: Wrap(
              children: dataList,
              spacing: 30,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

//持久化
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> dataList =[];

  @override
  Widget build(BuildContext context) {

    _show();

    return Container(
//      margin: EdgeInsets.only(top: 100),
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(600),
            child: ListView.builder(
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(dataList[index]),
                );
              },
              itemCount: dataList.length,
            ),
          ),

          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(375),
                child: RaisedButton(
                  onPressed: _addData,
                  child: Text('增加'),
                ),
              ),

              Container(
                width: ScreenUtil().setWidth(375),
                child: RaisedButton(
                  onPressed: _removeData,
                  child: Text('清空'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _show() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      if(shared.getStringList('dataList') != null){
        dataList = shared.getStringList('dataList');
      }else{
        dataList = [];
      }
    });
  }

  _addData() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    dataList.add('持久化一条数据');
    shared.setStringList('dataList', dataList);

    _show();
  }

  _removeData() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.remove('dataList');

    _show();
  }
}


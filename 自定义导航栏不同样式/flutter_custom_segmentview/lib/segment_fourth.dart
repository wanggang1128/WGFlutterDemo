import 'package:flutter/material.dart';

class SegmentFourth extends StatefulWidget {
  @override
  _SegmentFourthState createState() => _SegmentFourthState();
}

class _SegmentFourthState extends State<SegmentFourth> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        title: _segmentTile(),
      ),
      body: _bodyWidget(context, currentIndex),
    );
  }

  //内容组件
  Widget _bodyWidget(context, index) {
    int indx = index;
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('${indx}',style: TextStyle(fontSize: 50,color: Colors.red),),
        )
      ],
    );
  }
  

  //segment组件
  Widget _segmentTile() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20,right: 20,top: 2,bottom: 2),
          decoration: BoxDecoration(
            color: currentIndex==0?Colors.blue:Colors.white,
            border: Border(
              top: BorderSide(color: Colors.black38,width: 1),
              bottom: BorderSide(color: Colors.black38,width: 1),
              left: BorderSide(color: Colors.black38,width: 1),
              ),
          ),
          child: InkWell(
            onTap: (){
              setState(() {
                currentIndex = 0;
              });
            },
            child: Text(
              '个人订单',
              style: TextStyle(
                  color: currentIndex==0?Colors.white:Colors.blue,
                  fontSize: 18
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20,right: 20,top: 2,bottom: 2),
          decoration: BoxDecoration(
            color: currentIndex==1?Colors.blue:Colors.white,
            border: Border(
              top: BorderSide(color: Colors.black38,width: 1),
              bottom: BorderSide(color: Colors.black38,width: 1),
              right: BorderSide(color: Colors.black38,width: 1),
            ),
          ),
          child: InkWell(
            onTap: (){
              setState(() {
                currentIndex = 1;
              });
            },
            child: Text(
              '专科组订单',
              style: TextStyle(
                  color: currentIndex==1?Colors.white:Colors.blue,
                  fontSize: 18
              ),
            ),
          ),
        ),
      ],
    );
  }
}

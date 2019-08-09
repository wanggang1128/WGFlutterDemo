import 'package:flutter/material.dart';
import 'dart:convert';
import '../model/detail.dart';
import '../service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {

  DetailsModel detailsModel;

  //tabBar是否选中
  bool isLeft = true;
  bool isRight = false;

  //改变tabBar的状态
  changeDetailsTabbar(String changeState){

    if(changeState == 'left'){
      isLeft = true;
      isRight = false;
    }else{

      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  //请求商品信息
  getGoodsInfo(String id) async {

    var formData = {'goodId':id};
    await requestPost('getGoodDetailById', formData: formData).then((val){

      var responseData= json.decode(val.toString());
      detailsModel=DetailsModel.fromJson(responseData);

      notifyListeners();
    });
  }

}

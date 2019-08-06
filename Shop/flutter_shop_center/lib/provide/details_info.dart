import 'package:flutter/material.dart';
import 'dart:convert';
import '../model/detail.dart';
import '../service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {

  DetailsModel detailsModel;

  //请求商品信息
  getGoodsInfo(String id){

    var formData = {'goodId':id};
    requestPost('getGoodDetailById', formData: formData).then((val){

      var resData = json.decode(val.toString());
      detailsModel = DetailsModel.fromJson(resData);
      notifyListeners();
    });
  }

}

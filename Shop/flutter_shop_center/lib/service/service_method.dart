import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';
import '../config/service_url.dart';

//获取首页主题内容
Future getHomePageContent() async{

  try{
    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    var formData = {
      'lon':'115.02932',
      'lat':'35.76189'
    };
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200){
      //success
      return response.data;
    }else{
      throw Exception('接口异常');
    }
  }catch(e){
    return print('======>${e}');
  }
}

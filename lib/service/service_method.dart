import 'package:dio/dio.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'dart:async';
import 'dart:io';
import '../service/service_method.dart';

//获取首页主体内容
Future getHomePageContent() async {
  try{
    print("start to get homepage..............");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    var formData = {
      'lon' : '115.02932',
      'lat' : '35.76189'
    };
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception("后端接口异常");
    }
  }catch(e){
    return print('ERROR: ===========>{$e}');
  }
}
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

//获取火爆专区方法
Future getHomePageBelowContent() async {
  try{
    print("start to get homepage below..............");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    int page = 1;
    response = await dio.post(servicePath['homePageBelowContent'], data: page);
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception("后端接口异常");
    }
  }catch(e){
    return print('ERROR: ===========>{$e}');
  }
}

Future request(configPath, {formData}) async{
  try{
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    if(formData == null){
      response = await dio.post(servicePath[configPath]);
    }else{
      response = await dio.post(servicePath[configPath], data: formData);
    }
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception("后端接口异常");
    }
  }catch(e){
    return print('ERROR: ===========>{$e}');
  }
}
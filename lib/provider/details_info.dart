import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;

  //从后台获取数据
  getGoodsInfo(String id) async{
    var formData = {
      'goodId': id
    };
    await request('getGoodDetailById', formData: formData).then((val){
      var responseData = json.decode(val);
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  //tabbar切换方法
  shiftTabBar(String changeState){
    if(changeState == 'left'){
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

}
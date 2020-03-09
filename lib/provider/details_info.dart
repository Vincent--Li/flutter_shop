import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  //从后台获取数据
  getGoodsInfo(String id){
    var formData = {
      'goodId': id
    };
    request('getGoodDetailById', formData: formData).then((val){
      var responseData = json.decode(val);
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

}
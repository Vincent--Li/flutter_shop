import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cartinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];

  save(goodsId, goodsName, count, price, images) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? []:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int iVal = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        tempList[iVal]['count'] = item['count'] + 1;
        cartList[iVal].count++;
        isHave = true;
        return;
      }
      iVal++;
    });

    if(!isHave){
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName' : goodsName,
        'count' : count,
        'price' : price,
        'images' : images,
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    print('字符串$cartString');
    print('数据模型$cartList');
    prefs.setString('cartInfo', cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    print('clear completed ..............');
    cartList.clear();
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if(cartString != null){
      List<Map> temp = (json.decode(cartString.toString()) as List).cast();
      temp.forEach((item){
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
  }
}
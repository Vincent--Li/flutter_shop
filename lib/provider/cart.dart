import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cartinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];
  double allPrice = 0; //总价
  int allGoodsCount = 0; //商品数量

  bool selectAllBtnValue = true;

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
        'isCheck' : true
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    if(tempList.where((item){
      return item['isCheck'] == true;
    }).length == tempList.length){
      selectAllBtnValue = true;
    }else{
      selectAllBtnValue = false;
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    getCartInfo();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList.clear();
    allPrice = 0;
    allGoodsCount = 0;
    selectAllBtnValue = false;

    getCartInfo();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if(cartString != null){
      List<Map> temp = (json.decode(cartString.toString()) as List).cast();

      allPrice = 0;
      allGoodsCount = 0;
      temp.forEach((item){
        if(item['isCheck']){
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }

  removeItem(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    var temp = cartString == null ? []:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    var index = 0;
    var delIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'].toString() == goodsId){
        delIndex = index;
      }
      index++;
    });

    tempList.removeAt(delIndex);

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();

  }

  selectItem(CartInfoModel cartInfoModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    var temp = cartString == null ? []:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    tempList.forEach((item){
      if(item['goodsId'] == cartInfoModel.goodsId){
        item['isCheck'] = !cartInfoModel.isCheck;
      }
    });

    if(tempList.where((item){
      return item['isCheck'] == true;
    }).length == tempList.length){
      selectAllBtnValue = true;
    }else{
      selectAllBtnValue = false;
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }

  selectAllItem(bool val ) async{

    selectAllBtnValue = val;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    var temp = cartString == null ? []:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    tempList.forEach((item){
        item['isCheck'] = val;
    });

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }

  incItemNumber(CartInfoModel cartInfoModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    var temp = cartString == null ? []:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    tempList.forEach((item){
      if(item['goodsId'] == cartInfoModel.goodsId){
        item['count'] = item['count'] + 1;
      }
    });

    if(tempList.where((item){
      return item['isCheck'] == true;
    }).length == tempList.length){
      selectAllBtnValue = true;
    }else{
      selectAllBtnValue = false;
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();

  }

  decItemNumber(CartInfoModel cartInfoModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    var temp = cartString == null ? []:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    tempList.forEach((item){
      if(item['goodsId'] == cartInfoModel.goodsId){
        if(item['count'] > 1){
          item['count'] = item['count'] - 1;
        }
      }
    });

    if(tempList.where((item){
      return item['isCheck'] == true;
    }).length == tempList.length){
      selectAllBtnValue = true;
    }else{
      selectAllBtnValue = false;
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }
}
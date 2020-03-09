import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_goods_list.dart';

class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryListData> goodsList = [];

  getGoodsList(List<CategoryListData> list ){
    goodsList =list == null?[]:list;
    notifyListeners();
  }

  getMoreList(List<CategoryListData>  list){
    goodsList.addAll(list == null?[]:list);
    notifyListeners();
  }
}
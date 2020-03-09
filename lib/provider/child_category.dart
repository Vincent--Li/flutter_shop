import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];

  int childIndex = 0; //子类高亮索引
  String subId;

  //大类切换, 小类需要清零
  getChildCategory(List<BxMallSubDto> list){

    childIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = list[0].mallCategoryId;
    all.mallSubId = '';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String id){
    childIndex = index;
    subId = id;
    notifyListeners();
  }


}
import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];

  int childIndex = 0; //子类高亮索引
  String subId;
  String categoryId;
  int page =1; //列表页数
  String noMoreText = '';//显示没有数据的文字

  //大类切换, 小类需要清零
  getChildCategory(List<BxMallSubDto> list){

    page=1;
    childIndex = 0;
    noMoreText = '';
    categoryId = list[0].mallCategoryId;
    subId = list[0].mallSubId;
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
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  addPage(){
    page++;
  }

  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();

  }


}
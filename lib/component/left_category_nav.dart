import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods_list.dart';
import 'package:flutter_shop/provider/category_goods_list.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import '../model/category.dart';
import 'dart:convert';



class LeftCategoryNav extends StatelessWidget {


  List<CategoryListData> goodsList = [];

  @override
  Widget build(BuildContext context) {
    _getCategory(context);
    _getGoodsList(context);

    return Container(
      width: ScreenUtil().setHeight(150),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: Provide<ChildCategory>(
        builder: (context, child, val){

          List<CategoryData> categoryList = Provide.value<ChildCategory>(context).categoryList;

          return ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (context, index){
                return _leftInkWell(context, categoryList, index);
              }
          );
        },
      ),
    );
  }

  void _getCategory(BuildContext context) async {
    await request('getCategory').then((val){
      var data = json.decode(val);
      CategoryModel model  = CategoryModel.fromJson(data);

      Provide.value<ChildCategory>(context).getCategory(model.data);
      Provide.value<ChildCategory>(context).getChildCategory(model.data[0].bxMallSubDto);
    });
  }

  void _getGoodsList(BuildContext context, {String categoryId}) async {
    var data = {
      'categoryId': categoryId==null?'4':categoryId,
      'categorySubId': '',
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val){
      var data = json.decode(val);
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }

  Widget _leftInkWell(BuildContext context, List<CategoryData> categoryList, int index){
    bool isClicked = (index == Provide.value<ChildCategory>(context).listIndex);

    return InkWell(
      onTap: (){

        Provide.value<ChildCategory>(context).changeListIndex(index);

        var childList = categoryList[index].bxMallSubDto;
        var categoryId = categoryList[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
        _getGoodsList(context, categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClicked?Color.fromRGBO(236, 236, 236, 1):Colors.white,
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12)
          ),
        ),
        child: Text(categoryList[index].mallCategoryName, style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ), ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/category_goods_list.dart';
import 'package:flutter_shop/provider/category_goods_list.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:flutter_shop/provider/current_index.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class TopNavigator extends StatelessWidget {
  
  final List navigatorList;

  const TopNavigator({Key key, this.navigatorList}) : super(key: key);
  
  Widget _gridViewItemUI(BuildContext context, item, index){
    return InkWell(
      onTap: (){
        CategoryData categoryData = CategoryData.fromJson(item);

        Provide.value<ChildCategory>(context).getChildCategory(categoryData.bxMallSubDto);
        _getGoodsList(context, categoryId: categoryData.mallCategoryId);
        Provide.value<ChildCategory>(context).changeListIndex(index);
        Provide.value<CurrentIndexProvide>(context).changeIndex(1);

      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95),),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    if(this.navigatorList.length>10){
      this.navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(250),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.asMap().map((index, item){
          return MapEntry(index, _gridViewItemUI(context, item, index));
        }).values.toList(),
      ),
    );
  }

  void _getGoodsList(context, {String categoryId}) async {
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
}

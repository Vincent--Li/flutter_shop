import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/category_goods_list.dart';
import 'package:flutter_shop/provider/category_goods_list.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory){
        return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(560),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12)
                )
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index){
                  return _rightInkWell(childCategory.childCategoryList[index], index);
              }
            )
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDto item, int index){
    bool isChecked = (index == Provide.value<ChildCategory>(context).childIndex);
    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildIndex(index,item.mallSubId);
        _getGoodsList(categoryId: item.mallCategoryId, categorySubId: item.mallSubId);
      },

      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isChecked?Colors.pink:Colors.black
          ),
        ),
      ),
    );
  }

  void _getGoodsList({String categoryId, String categorySubId}) async {
    print('_getGoodsList: ${categoryId}, ${categorySubId}');
    var data = {
      'categoryId': categoryId == null?'4':categoryId,
      'categorySubId': categorySubId == null?'':categorySubId,
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val){
      var data = json.decode(val);
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }
}

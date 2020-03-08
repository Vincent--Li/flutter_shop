import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods_list.dart';
import 'package:flutter_shop/provider/category_goods_list.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import '../model/category.dart';
import 'dart:convert';



class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  var listIndex = 0;

  List<CategoryData> list = [];

  List<CategoryListData> goodsList = [];


  @override
  void initState() {
    super.initState();
    _getCategory();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
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
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return _leftInkWell(index);
        }
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val){
      var data = json.decode(val);
      CategoryModel model  = CategoryModel.fromJson(data);
      setState(() {
        list = model.data;
      });
//      model.data.forEach((item)=> print(item.mallCategoryName));
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
    });
  }

  void _getGoodsList({String categoryId}) async {
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

  Widget _leftInkWell(int index){
    bool isClicked = (index == listIndex);

    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
        _getGoodsList(categoryId: categoryId);
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
        child: Text(list[index].mallCategoryName, style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ), ),
      ),
    );
  }
}

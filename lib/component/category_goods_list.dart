import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods_list.dart';
import 'package:flutter_shop/provider/category_goods_list.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data){
        try{
          scrollController.jumpTo(0.0);
        }catch(e){
          print('进入页面第一次初始化: ${e}');
        }

        if(data.goodsList.length >0){
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(560),
              child: EasyRefresh(
                header: ClassicalHeader(
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  infoText: "加载中====",
                  showInfo: true,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  refreshedText: "下拉刷新",

                ),
                footer: ClassicalFooter(
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    infoColor: Colors.pink,
                    infoText: "加载中----",
                    showInfo: true,
                    noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                    loadedText: "上拉加载"
                ),
                child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: data.goodsList.length,
                    itemBuilder: (context, index){
                      return _listWidget(data.goodsList, index);
                    }),
                onLoad: () async{
                  _getMoreList();
                },
                onRefresh: (){
                },
              )
            ),
          );
        }else{
          return Text('暂无数据');
        }

      }
    );
  }


  Widget _goodsImage(List newList, int index){
    return Container(
      width: ScreenUtil().setWidth(180),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList, index){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      width: ScreenUtil().setWidth(330),
      child: Text(
        newList[index].goodsName,
        maxLines: 2, 
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28)
        ),
      ),
    );
  }

  Widget _goodsPrice(List newList, index){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Text('价格: ￥${newList[index].presentPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Colors.pink
            ),
          ),
          Text('价格: ￥${newList[index].oriPrice}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              decorationColor: Colors.grey
            ),
          )
        ],
      ),
    );
  }

  Widget _listWidget(List<CategoryListData> newList, index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/detail?id=${newList[index].goodsId}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList,index),
                _goodsPrice(newList,index)
              ],
            )
          ],
        ),
      ),
    );
  }

  void _getMoreList({String categoryId, String categorySubId}) async {
    print('_getGoodsList: ${categoryId}, ${categorySubId}');
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page
    };
    print("page ${Provide.value<ChildCategory>(context).page}"
        " categoryId ${Provide.value<ChildCategory>(context).categoryId}"
        " subId ${Provide.value<ChildCategory>(context).subId}");
    await request('getMallGoods', formData: data).then((val){
      var data = json.decode(val);
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if(goodsList.data == null){
        Fluttertoast.showToast(
          msg: "已经到底了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16,
        );
        Provide.value<ChildCategory>(context).changeNoMore("没有更多");
        Provide.value<ChildCategory>(context).addPage();
      }else{
        Provide.value<CategoryGoodsListProvide>(context).getMoreList(goodsList.data);
        Provide.value<ChildCategory>(context).addPage();
      }

    });
  }

}

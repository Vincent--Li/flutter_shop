import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/category_goods_list.dart';
import 'package:flutter_shop/provider/category_goods_list.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data){
        if(data.goodsList.length >0){
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(560),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context, index){
                    return _listWidget(data.goodsList, index);
                  }),
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

  Widget _listWidget(List newList, index){
    return InkWell(
      onTap: (){},
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

}

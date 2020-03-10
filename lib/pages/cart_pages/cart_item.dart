import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cartinfo.dart';
import 'package:flutter_shop/pages/cart_pages/cart_count.dart';
import 'package:flutter_shop/provider/cart.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:provide/provide.dart';

class CartItem extends StatelessWidget {

  final CartInfoModel item;

  const CartItem({Key key, this.item}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12)
        ),
      ),
      child: Row(
        children: <Widget>[
          _cartCheckButton(context, item),
          _cartImage(context, item.goodsId),
          _cartGoodsName(context, item.goodsId),
          _cartPrice(context, item)
        ],
      ),
    );
  }

  //checkbox
  Widget _cartCheckButton(BuildContext context, CartInfoModel item){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val){
          Provide.value<CartProvide>(context).selectItem(item);
        },
      ),
    );
  }

  //image
  Widget _cartImage(context, goodsId){
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12)
      ),
      child: InkWell(
        onTap: (){
          Application.router.navigateTo(context, '/detail?id=${goodsId}');
        },
        child: Image.network(item.images),
      ),
    );
  }

  //goods name
  Widget _cartGoodsName(context, goodsId){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: (){
              Application.router.navigateTo(context, '/detail?id=${goodsId}');
            },
            child: Text(item.goodsName),
          ),
          CartCount(item: item),
        ],
      ),
    );
  }

  //price
  Widget _cartPrice(context, item){
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: (){
                Provide.value<CartProvide>(context).removeItem(item.goodsId);
              },
              child: Icon(Icons.delete, color: Colors.black26, size: 30,),
            ),
          )
        ],
      ),
    );
  }







}

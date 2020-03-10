import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cartinfo.dart';
import 'package:flutter_shop/pages/cart_pages/cart_count.dart';

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
          _cartCheckButton(),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice()
        ],
      ),
    );
  }

  //checkbox
  Widget _cartCheckButton(){
    return Container(
      child: Checkbox(
        value: true,
        activeColor: Colors.pink,
        onChanged: (bool val){

        },
      ),
    );
  }

  //image
  Widget _cartImage(){
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }

  //goods name
  Widget _cartGoodsName(){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(),
        ],
      ),
    );
  }

  //price
  Widget _cartPrice(){
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: (){

              },
              child: Icon(Icons.delete, color: Colors.black26, size: 30,),
            ),
          )
        ],
      ),
    );
  }







}

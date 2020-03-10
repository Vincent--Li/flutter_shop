import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cartinfo.dart';
import 'package:flutter_shop/provider/cart.dart';
import 'package:provide/provide.dart';

import 'cart_pages/cart_item.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<CartInfoModel> cartList = Provide.value<CartProvide>(context).cartList;

            return ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index){
                  return Card(
                    child: CartItem(item: cartList[index]),
                  );
                });
          }else{
            return Text("正在加载");
          }
        },
      ),
    );
  }


  Future<String> _getCartInfo(BuildContext context) async{
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}


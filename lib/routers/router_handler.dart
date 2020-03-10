import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import '../pages/details_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context , Map<String, List<String>> params){
    String goodsId = params['id'].first;
    print('index>details goodsId is ${goodsId}');
    return DetailsPage(goodsId: goodsId,);
  }
);

Handler cartHandler = Handler(
    handlerFunc: (BuildContext context , Map<String, List<String>> params){
      return CartPage();
    }
);
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("商品列表"),
    );
  }

  void _getGoodsList() async {
    var data = {
      'categoryId': '4',
      'categorySubId': '',
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val){
      var data = json.decode(val);
      print(data);
    });
  }
}

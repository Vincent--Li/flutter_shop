import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/component/category_goods_list.dart';
import 'package:flutter_shop/component/left_category_nav.dart';
import 'package:flutter_shop/component/right_category_nav.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '商品分类',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white
          ),
        ),

      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            )

          ],
        ),
      ),
    );
  }
}

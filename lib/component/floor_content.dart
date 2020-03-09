import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';

class FloorContent extends StatelessWidget {

  final List floorGoodList;

  const FloorContent({Key key, this.floorGoodList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }

  Widget _firstRow(BuildContext context){
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, floorGoodList[1]),
            _goodsItem(context, floorGoodList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(BuildContext context){
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodList[3]),
        _goodsItem(context, floorGoodList[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context, Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          Application.router.navigateTo(context, '/detail?id=${goods['goodsId']}');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

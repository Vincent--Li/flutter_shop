import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cartinfo.dart';
import 'package:flutter_shop/provider/cart.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  final CartInfoModel item;

  const CartCount({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context, item),
          _countValue(context, item),
          _IncreBtn(context, item),
        ],
      ),
    );
  }

  Widget _reduceBtn(BuildContext context, CartInfoModel item){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).decItemNumber(item);
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(width: 1, color:Colors.black12)
          )
        ),
        child: Text('-'),
      ),
    );
  }

  Widget _IncreBtn(BuildContext context, CartInfoModel item){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).incItemNumber(item);
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(width: 1, color:Colors.black12)
            )
        ),
        child: Text('+'),
      ),
    );
  }

  Widget _countValue(BuildContext context, CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}

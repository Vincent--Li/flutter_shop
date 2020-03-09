import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/provider/details_info.dart';
import 'package:provide/provide.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String goodsDetails = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    List<GoodComments> goodsComments = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodComments;


    return Provide<DetailsInfoProvide>(
      builder: (context, child, val){
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        if(isLeft){
          return Container(
            child: Html(
                data: goodsDetails
            ),
          );
        }else{
          if(goodsComments == null || goodsComments.length == 0){
            return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              child: Text('暂无数据'),
            );
          }else{
            return Container(
              width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setHeight(1000),
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: goodsComments.length,
                  itemBuilder: (context, index){
                    return Text('用户: ${goodsComments[index].userName}: ${goodsComments[index].comments}, '
                        '评分: ${goodsComments[index].sCORE} 于: ${goodsComments[index].discussTime}');
                  }
              ),
            );
          }
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_shop/routers/application.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwiperDIY extends StatelessWidget {

  final List swiperDataList;

  const SwiperDIY({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(275),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              Application.router.navigateTo(context, '/detail?id=${swiperDataList[index]['goodsId']}');
            },
            child: Image.network("${swiperDataList[index]['image']}"),
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

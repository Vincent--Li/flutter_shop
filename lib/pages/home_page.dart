import 'package:flutter/material.dart';
import 'package:flutter_shop/component/swiper_diy.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  void initState() {
    // TODO: implement initState
    getHomePageContent().then((val){
      setState(() {
        homePageContent = val.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, );

    print('设备像素密度:${ScreenUtil.pixelRatio}');
    print('设备高:${ScreenUtil.screenHeight}');
    print('设备宽:${ScreenUtil.screenWidth}');

    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            print(data);
            List<Map> swiper = (data['data']['slides'] as List).cast();
            return Column(
              children: <Widget>[
                SwiperDIY(swiperDataList: swiper,)
              ],
            );
          }else{
            return Center(
              child: Text(
                "加载中", 
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28)
                ),
              ),
            );
          }
        },
      ),
    );
  }
}


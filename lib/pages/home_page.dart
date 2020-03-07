import 'package:flutter/material.dart';
import 'package:flutter_shop/component/ad_banner.dart';
import 'package:flutter_shop/component/leader_phone.dart';
import 'package:flutter_shop/component/recommend.dart';
import 'package:flutter_shop/component/swiper_diy.dart';
import 'package:flutter_shop/component/top_navigator.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  String homePageContent = '正在获取数据';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("homepage loading...");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
        //futureBuilder用来解决异步加载数据然后渲染的问题
        future: getHomePageContent(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList = (data['data']['recommend'] as List).cast();

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDIY(swiperDataList: swiper,),
                  TopNavigator(navigatorList: navigatorList,),
                  AdBanner(adPicture: adPicture,),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                  Recommend(recommandList: recommendList),
                ],
              ),
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


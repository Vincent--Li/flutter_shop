import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_shop/component/ad_banner.dart';
import 'package:flutter_shop/component/floor_content.dart';
import 'package:flutter_shop/component/floor_title.dart';
import 'package:flutter_shop/component/leader_phone.dart';
import 'package:flutter_shop/component/recommend.dart';
import 'package:flutter_shop/component/swiper_diy.dart';
import 'package:flutter_shop/component/top_navigator.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/service/service_method.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  String homePageContent = '正在获取数据';
  int page = 1;
  List<Map> hotGoodsList =[] ;


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("homepage loading...");
    var formData = {
      "page": page
    };
    request('homePageBelowContent', formData: formData).then((val){
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
        //futureBuilder用来解决异步加载数据然后渲染的问题
        future: request('homePageContent', formData: {
          'lon': '115.02932',
          'lat': '35.76189'
        }),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList = (data['data']['recommend'] as List).cast();
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor3 = (data['data']['floor3'] as List).cast();


            return EasyRefresh(
              header: ClassicalHeader(
                bgColor: Colors.white,
                textColor: Colors.pink,
                infoColor: Colors.pink,
                infoText: "加载中====",
                showInfo: true,
                noMoreText: "",
                refreshedText: "下拉刷新",

              ),
              footer: ClassicalFooter(
                bgColor: Colors.white,
                textColor: Colors.pink,
                infoColor: Colors.pink,
                infoText: "加载中----",
                showInfo: true,
                noMoreText: "",
                loadedText: "上拉加载"
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDIY(swiperDataList: swiper,),
                  TopNavigator(navigatorList: navigatorList,),
                  AdBanner(adPicture: adPicture,),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                  Recommend(recommandList: recommendList),
                  FloorTitle(picture_address: floor1Title),
                  FloorContent(floorGoodList: floor1,),
                  FloorTitle(picture_address: floor2Title),
                  FloorContent(floorGoodList: floor2,),
                  FloorTitle(picture_address: floor3Title),
                  FloorContent(floorGoodList: floor3,),
                  _hotGoods(),
                ],
              ),
              onLoad: () async {
                print("开始加载更多");
                var formData = {
                  "page": page
                };
                await request('homePageBelowContent', formData: formData).then((val){
                  var data = json.decode(val.toString());
                  try{
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    if(newGoodsList != null){
                      setState(() {
                        hotGoodsList.addAll(newGoodsList);
                        page++;
                      });
                    }
                  }catch(e){
                    print(e);
                  }


                });
              },
              onRefresh: () async {
                print("开始刷新");
                var formData = {
                  "page": 1
                };
                await request('homePageBelowContent', formData: formData).then((val){
                  var data = json.decode(val.toString());
                  try{
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    if(newGoodsList != null){
                      setState(() {
                        hotGoodsList = newGoodsList;
                        page = 1;
                      });
                    }
                  }catch(e){
                    print(e);
                  }
                });
              },
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

  Widget _hotGoods(){
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList()
        ],
      ),
    );
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    color: Colors.transparent,
    padding: EdgeInsets.all(5),
    child: Text("火爆专区"),
  );

  Widget _wrapList(){
    if(hotGoodsList.length!=0){
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap: (){
            Application.router.navigateTo(context, '/detail?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(val['image'], width: ScreenUtil().setWidth(372),),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26)),

                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['mallPrice']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text('');
    }
  }


}


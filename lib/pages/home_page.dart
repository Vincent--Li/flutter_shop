import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String inputText = "";
  String responseData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("美好人间"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: "美女类型"
                  ),
                  onChanged: (text){
                    setState(() {
                      this.inputText = text;
                    });
                  },
                ),

                RaisedButton(
                  child: Text("点击请求数据"),
                  onPressed: (){
                    _choiceAction();
                  },
                ),
                SizedBox(height: 10,),
                Text(this.responseData)
              ],
            ),
          ),
        ),
      )
    );
  }

  void _choiceAction(){
    print("开始选择喜欢的类型。。。。。。。。。。。");
        if(this.inputText == ''){
          showDialog(
              context: context,
              builder: (context)=>AlertDialog(
                title: Text("美女类型不能为空"),

              )
          );
        }else{
          getHttp().then((val){
            setState(() {
              this.responseData = val['data']['name'].toString();
            });
          });
        }
  }

  Future getHttp() async{
    try{
      Response response;
      Dio dio = new Dio();
      var data = {'name': inputText};
      response = await dio.get(
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
        queryParameters: data,
      );
      return response.data;
    }catch(e){
      return print(e);
    }
  }
}

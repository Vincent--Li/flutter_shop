import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/counter.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];


  @override
  Widget build(BuildContext context) {
    _show();

    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: ListView.builder(itemCount: testList.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(testList[index]),
                    );
                  }),
            ),
            RaisedButton(
              child: Text("增加" ),
              onPressed: (){
                _add();
              },
            ),
            RaisedButton(
              child: Text("清空" ),

              onPressed: (){
                _clear();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _add() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String temp = 'you are the best';
    testList.add(temp);
    preferences.setStringList('testInfo', testList);
    _show();
  }

  void _show() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getStringList('testInfo') != null){
      setState(() {
        testList = preferences.getStringList('testInfo');
      });
    }
  }

  void _clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    preferences.remove('testInfo');
    setState(() {
      testList = [];
    });
  }
}



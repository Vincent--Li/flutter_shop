import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/counter.dart';
import 'package:provide/provide.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            NumberTemp(),
            MyButton(),
          ],
        ),
      ),
    );
  }
}

class NumberTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 200),
      child: Provide<Counter>(
        builder: (context, child, counter){
          return Text(
              '${counter.value}',
            style: TextStyle(
              fontSize: 28
            ),
          );
        },
      ),
    );
  }
}


class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        Provide.value<Counter>(context).increment();
      },
      child: Text('incr'),
    );
  }
}



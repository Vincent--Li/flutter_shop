import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/counter.dart';
import 'package:provide/provide.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
      )
    );
  }
}
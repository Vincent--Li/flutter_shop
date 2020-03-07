import 'package:flutter/material.dart';

class LeaderPhone extends StatelessWidget {

  final String leaderImage;
  final String leaderPhone;

  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){

        },
        child: Image.network(leaderImage),
      ),
    );
  }
}

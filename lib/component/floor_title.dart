import 'package:flutter/material.dart';

class FloorTitle extends StatelessWidget {
  
  final String picture_address;

  const FloorTitle({Key key, this.picture_address}) : super(key: key);
  
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(picture_address),
    );
  }
}

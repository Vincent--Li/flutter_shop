import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {

  final String adPicture;

  const AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Image.network(adPicture),
      color: Colors.red,
    );
  }
}

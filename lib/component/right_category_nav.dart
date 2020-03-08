import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:provide/provide.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  var listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory){
        return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(530),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12)
                )
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index){
                  return _rightInkWell(childCategory.childCategoryList[index], index);
              }
            )
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDto item, int index){
    bool isChecked = (index == listIndex);
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
      },

      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isChecked?Colors.pink:Colors.black
          ),
        ),
      ),
    );
  }
}

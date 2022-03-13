import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AppbarIconbutton extends StatelessWidget {

  var bg_color;
  var height;
  var radius;
  var width;
  var color;
  var icon_name;
  var onclick;

  AppbarIconbutton({
    required this.height,
    required this.width,
    required this.radius,
    required this.bg_color,
    required this.color,
    required this.icon_name,
    required this.onclick,

 });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: new BoxDecoration(
          color: bg_color,
          borderRadius: BorderRadius.circular(radius)),
      child: IconButton(
        icon: icon_name,
        color: color,
        onPressed: onclick,
      ),
    );
  }
}

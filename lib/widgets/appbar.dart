import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appbar_iconbutton.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  // const Appbar({Key? key}) : super(key: key);
  var title;
  Appbar({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 23.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppbarIconbutton(
            height: 20.0,
            width: 20.0,
            radius: 30.0,
            bg_color: Color(0xfff77883),
            color: Colors.white,
            icon_name: Icon(Icons.arrow_back_ios_outlined, size: 19),
            onclick: () {
              Navigator.of(context).pop();
            }),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}

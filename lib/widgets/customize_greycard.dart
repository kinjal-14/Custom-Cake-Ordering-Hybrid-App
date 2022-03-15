import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomizeGreyCard extends StatelessWidget {
  var text1;
  var text2;
  var height;
  var width;
  var font_size;

  CustomizeGreyCard({
    required this.text1,
    required this.text2,
    required this.height,
    required this.width,
    required this.font_size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          // side: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
        color: Colors.grey[200],
        child: Container(
          // color: Color(0xffd3d3d3),
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text1, style: TextStyle(
                    fontSize: font_size,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
                Text(text2, style: TextStyle(
                  fontSize: font_size,
                  color: Colors.black,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

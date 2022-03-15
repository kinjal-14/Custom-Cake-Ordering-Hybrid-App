import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomizeCard extends StatelessWidget {
  var name;
  var image;
  var image_height;
  var image_width;
  var image_fit;
  var font_weight;
  var font_size;

  CustomizeCard({
    required this.image,
    required this.name,
    required this.image_height,
    required this.image_width,
    required this.image_fit,
    // required this.font_weight,
    // required this.font_size,

});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image(
          image: AssetImage(image),
          height: image_height,
          width: image_width,
          fit: image_fit,
        ),
        name
        // Text(name,style: TextStyle(
        //     fontWeight: font_weight, fontSize: font_size))
      ],
    );
  }
}

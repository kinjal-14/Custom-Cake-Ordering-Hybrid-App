import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  var bgcolor;
  var fontsize;
  var buttonsize;
  var onclick;
  var text;

  CustomButton({
    this.fontsize,
    this.buttonsize,
    this.bgcolor,
    this.text,
    this.onclick,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: fontsize),
            primary: bgcolor,
            minimumSize: buttonsize,
            shape: StadiumBorder()),
        onPressed: onclick,
        child: Center(child: Text(text)),
      ),
    );
  }
}

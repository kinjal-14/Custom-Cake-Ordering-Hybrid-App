import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // const CustomTextField({Key? key}) : super(key: key);
  var hint;
  var secure;
  var controller;
  var keyboardtype;
  var onSaved;
  var action;
  var validator;
  CustomTextField({
    this.hint,
    this.secure,
    this.controller,
    // this.keyboardtype,
    this.onSaved,
    this.action,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: "hello",
      autofocus: false,
      // keyboardType: keyboardtype,
      validator: validator,
      controller: controller,
      obscureText: secure,
      onSaved: onSaved,
      textInputAction: action,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.3),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.3),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hint),
    );
  }
}

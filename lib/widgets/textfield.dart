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
  var autoHint;
  var onComplete;
  var type;
  CustomTextField({
    this.hint,
    this.secure,
    this.controller,
    // this.keyboardtype,
    this.onSaved,
    this.action,
    this.validator,
    this.autoHint,
    this.onComplete,
    this.type,
  });
  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: TextFormField(
        keyboardType: type,
        onEditingComplete: onComplete,
        // initialValue: "hello",
        autofocus: false,
        // keyboardType: keyboardtype,
        autofillHints: autoHint,
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
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/textfield.dart';

class Shipping extends StatefulWidget {
  const Shipping({Key? key}) : super(key: key);

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: "SHIPPING"),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          // color: Colors.amber,
          height: (MediaQuery.of(context).size.height) / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                // color: Colors.white,
                height: (MediaQuery.of(context).size.height) / 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 5.0),
                              ],
                              borderRadius:
                              BorderRadius.all(Radius.circular(55))),
                          child: CircleAvatar(
                            backgroundImage:
                            AssetImage("assets/images/cake4.jpg"),
                            radius: 60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(hint: "Address 1",secure: false,)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(hint: "Address 2",secure: false,)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(hint: "Postal Code",secure: false,)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(hint: "City",secure: false,)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(hint: "State",secure: false,)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButton(
                  fontsize: 18.0,
                  buttonsize:
                  Size((MediaQuery.of(context).size.width) / 1, 50.0),
                  bgcolor: Color(0xfff77883),
                  text: 'Buy',
                  onclick: () {
                    Navigator.pushNamed(context, "/payment");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/textfield.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: "PAYMENT"),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          // color: Colors.amber,
          height: (MediaQuery.of(context).size.height) / 1.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              BorderRadius.all(Radius.circular(55)),),
                          child: CircleAvatar(
                            backgroundImage:
                            AssetImage("assets/images/cake1.jpg"),
                            radius: 60,

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Card Information",
                    style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(hint: "Full Name",secure: false,)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Card Number",
                    style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(hint: "ex. 1234 5678 9999 0000",secure: false,)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(hint: "Exp. Date",secure: false,)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(hint: "CVV",secure: false,)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButton(
                  fontsize: 18.0,
                  buttonsize:
                  Size((MediaQuery.of(context).size.width) / 1, 50.0),
                  bgcolor: Color(0xfff77883),
                  text: 'Continue',
                  onclick: () {

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

import 'package:cake_dreams/models/user_model.dart';
import 'package:cake_dreams/widgets/appbar.dart';
import 'package:cake_dreams/widgets/customize_greycard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/appbar_iconbutton.dart';
import '../widgets/custom_button.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // User? user = FirebaseAuth.instance.currentUser;
  // UserModel currentUser = UserModel();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.currentUser = UserModel.fromMap(value.data());
  //     setState(() {
  //
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: "ACCOUNT",
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          // color: Colors.amber,
          height: (MediaQuery.of(context).size.height) / 1.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                // color: Colors.white,
                height: (MediaQuery.of(context).size.height) / 5,
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
                                AssetImage("assets/images/splashLogo.png"),
                            radius: 60,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${currentUser.name}",
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height) / 3,
                // color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: InkWell(
                        // onTap: () => {Navigator.pushNamed(context, "/profile")},
                        child: CustomizeGreyCard(
                            text1: "Profile",
                            text2: ">",
                            height: 50.0,
                            width: (MediaQuery.of(context).size.width) / 1,
                            font_size: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: InkWell(
                        // onTap: () => {Navigator.pushNamed(context, "/profile")},
                        child: CustomizeGreyCard(
                            text1: "Your Orders",
                            text2: ">",
                            height: 50.0,
                            width: (MediaQuery.of(context).size.width) / 1,
                            font_size: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: InkWell(
                        // onTap: () => {Navigator.pushNamed(context, "/profile")},
                        child: CustomizeGreyCard(
                            text1: "Contact Us",
                            text2: ">",
                            height: 50.0,
                            width: (MediaQuery.of(context).size.width) / 1,
                            font_size: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomButton(
                        fontsize: 18.0,
                        buttonsize:
                            Size((MediaQuery.of(context).size.width) / 1, 50.0),
                        bgcolor: Color(0xfff77883),
                        text: 'Logout',
                        onclick: () {
                         logout(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Future<void> logout(BuildContext context) async{
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.pushNamed(context, "/home");
  //
  // }
}

import 'package:cake_dreams/models/demo_model.dart';
import 'package:cake_dreams/widgets/appbar.dart';
import 'package:cake_dreams/widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import '../widgets/appbar_iconbutton.dart';
import '../widgets/custom_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel currentUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      currentUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameController = new TextEditingController()
      ..text = currentUser.name.toString();
    phoneNumberController = new TextEditingController()
      ..text = currentUser.phone.toString();
    emailController = new TextEditingController()
      ..text = currentUser.email.toString();
    passwordController = new TextEditingController()
      ..text = currentUser.password.toString();
    return Scaffold(
      appBar: Appbar(title: "PROFILE"),
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
                                AssetImage("assets/images/cake19.jpg"),
                            radius: 60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: CustomTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Name");
                            }

                            return null;
                          },
                          hint: "Full Name",
                          secure: false,
                          controller: nameController,
                          // keyboardtype: TextInputType.emailAddress,
                          onSaved: (value) {
                            nameController.text = value!;
                          },
                          action: TextInputAction.next,
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Mobile Number");
                            }
                            if (!RegExp("^\\d{10}\$").hasMatch(value)) {
                              return ("Please Enter a valid Mobile Number");
                            }

                            return null;
                          },
                          hint: "Mobile Number",
                          secure: false,
                          controller: phoneNumberController,
                          // keyboardtype: TextInputType.emailAddress,
                          onSaved: (value) {
                            phoneNumberController.text = value!;
                          },
                          action: TextInputAction.next,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: CustomTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          hint: "Email Address",
                          secure: false,
                          controller: emailController,
                          // keyboardtype: TextInputType.emailAddress,
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          action: TextInputAction.next,
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Please Enter valid Password(Min. 6 Characters)");
                            }
                          },
                          hint: "Password",
                          secure: false,
                          controller: passwordController,
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          action: TextInputAction.done,
                        )),
                    SizedBox(
                      height: 45.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                            primary: Color(0xfff77883),
                            minimumSize:
                                Size((MediaQuery.of(context).size.width), 55.0),
                            shape: StadiumBorder()),
                        onPressed: () {
                          update();
                        },
                        child: const Text('Update'),
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

  void update() async {
    if (_formKey.currentState!.validate()) {
      sendData();
    }
  }

  resetEmail(String newEmail) async {
    var message;
    user?.updateEmail(newEmail);
    // User? user1 = await FirebaseAuth.instance.currentUser;
    // user1.updateEmail(newEmail)
    // user1?.updateEmail(newEmail)
    //     .then(
    //       (value) => message = 'Success',
    // )
    //     .catchError((onError) => message = 'error');
    // print(message);
  }

  sendData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    UserModel userModel = UserModel();
    userModel.email = emailController.text;
    userModel.uid = user!.uid;
    userModel.name = nameController.text;
    userModel.phone = phoneNumberController.text;
    userModel.password = passwordController.text;

    if (user?.email != emailController.text) {
      resetEmail(emailController.text.toString());
    }

    user
        ?.updatePassword(passwordController.text)
        .then((value) => print("success"))
        .catchError((onError) => "error");
    await firebaseFirestore
        .collection("users")
        .doc(user!.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Profile data updated successfully");

    // Navigator.pushNamed(context, "/home");
  }
}

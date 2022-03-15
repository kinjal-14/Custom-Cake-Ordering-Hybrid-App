import 'package:cake_dreams/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/textfield.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneNumberController =
      new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          leadingWidth: 20,
          titleSpacing: 0.0,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "SIGN UP",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Image(
              image: AssetImage(
                "assets/images/logo.png",
              ),
              width: 134,
              height: 134,
            )
          ]),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 27.0,
                            color: Color(0xfff77883),
                            fontWeight: FontWeight.bold),
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        mini: true,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                        if (!RegExp(
                                "^\\d{10}\$")
                            .hasMatch(value)) {
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: CustomTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please Enter Your Email");
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                      secure: true,
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
                    onPressed: () {signup(emailController.text, passwordController.text);},
                    child: const Text('Sign up'),
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Or",
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Already a Member?",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xfff77883),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
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
                    onPressed: () => Navigator.pushNamed(context, "/login"),
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void signup(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {sendData()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
        var snackBar = SnackBar(content: Text(e!.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  sendData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text;
    userModel.phone = phoneNumberController.text;
    userModel.password = passwordController.text;

    await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    var snackBar = SnackBar(content: Text("Account created successfully"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushNamed(context, "/home");
  }
}

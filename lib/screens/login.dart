import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/textfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
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
              "LOGIN",
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
                          return ("Password is required for login");
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
                    onPressed: () { login(emailController.text, passwordController.text);},
                    child: const Text('Login'),
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
                  "Don't have an account?",
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
                    onPressed: () => Navigator.pushNamed(context, "/signup"),
                    child: const Text('Sign up'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void login(String email, String password) async {

    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.pushNamed(context, "/home")
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
        var snackBar = SnackBar(content: Text(e!.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      });
    }
  }
}

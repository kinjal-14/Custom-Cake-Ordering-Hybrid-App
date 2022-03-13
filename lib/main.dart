import 'dart:async';
import 'package:cake_dreams/screens/account.dart';
import 'package:cake_dreams/screens/cart.dart';
import 'package:cake_dreams/screens/demo.dart';
import 'package:cake_dreams/screens/payment.dart';
import 'package:cake_dreams/screens/pre-made.dart';
import 'package:cake_dreams/screens/profile.dart';
import 'package:cake_dreams/screens/shipping.dart';

import 'screens/splash.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/cakeDetail.dart';
import 'screens/customize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasError){
            print("You have an error! ${snapshot.error.toString()}");
            return Text("Something went wrong");
          }else if(snapshot.hasData){
            return Splash();
          }
          else{
            return Splash();
            // return Center(
            //   child: CircularProgressIndicator(),
            // );
          }
        },
      ),
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/detail': (context) => Detail(),
        '/customize': (context) => Customize(),
        '/pre-made': (context) => PreMade(),
        '/account': (context) => Account(),
        '/profile': (context) => Profile(),
        '/cart': (context) => Cart(),
        '/shipping': (context) => Shipping(),
        '/payment': (context) => Payment(),
        '/demo': (context) => Demo(),
      },
    );
  }
}

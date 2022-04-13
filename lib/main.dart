import 'dart:async';
import 'package:cake_dreams/screens/account.dart';
import 'package:cake_dreams/screens/adminHome.dart';
import 'package:cake_dreams/screens/adminOrderDetail.dart';
import 'package:cake_dreams/screens/adminOrders.dart';
import 'package:cake_dreams/screens/cart.dart';
import 'package:cake_dreams/screens/contact.dart';
import 'package:cake_dreams/screens/demo.dart';
import 'package:cake_dreams/screens/order.dart';
import 'package:cake_dreams/screens/payment.dart';
import 'package:cake_dreams/screens/pre-made.dart';
import 'package:cake_dreams/screens/profile.dart';
import 'package:cake_dreams/screens/shipping.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{

}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51KkDW2B01bPVQ0Ks9ihEn79VB0yNCa5DyqRZQyeVOcNZ0hf5JgjnSqgVtlqAlroRGZogQOiJBe2569dkKivAlCjE00PI8E4uyH';
  Stripe.merchantIdentifier = 'cake';
  await Stripe.instance.applySettings();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,

  );
  final MacOSInitializationSettings initializationSettingsMacOS =
  MacOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  final Future<bool?>? result =  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
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
        '/adminHome': (context) => AdminHome(),
        '/adminOrders': (context) => AdminOrders(),
        '/adminOrderDetail': (context) => AdminOrderDetail(),
        '/order': (context) => Order(),
        '/contact': (context) => Contact(),
        '/demo': (context) => Demo(),

      },
    );
  }
}


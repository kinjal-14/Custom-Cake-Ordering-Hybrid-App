import 'package:cake_dreams/models/order_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';
import '../models/cart_products.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_button.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class AdminOrderDetail extends StatefulWidget {
  const AdminOrderDetail({Key? key}) : super(key: key);

  @override
  State<AdminOrderDetail> createState() => _AdminOrderDetailState();
}

class _AdminOrderDetailState extends State<AdminOrderDetail> {

  List<CartProducts> products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  fetchProducts(uid, id) async {
    dynamic result = await OrderProductManager().getProductList(uid, id);
    //dyna//mic result1 = await CartProductManager().totalPrices;
    if (result == null) {
      print("Product list null");
    }
    else {
      setState(() {
        products = result;
        //totals = result1;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var id = arg['id'];
    var orderType = arg['orderType'];
    var uid = arg['uid'];
    var address1 = arg['address1'];
    var address2 = arg['address2'];
    var postalCode = arg['postalCode'];
    var city = arg['city'];
    var state = arg['state'];
    var total = arg['total'];
    var name = arg['name'];
    var phone = arg['phone'];
    var email = arg['email'];



    fetchProducts(uid, id);
    return Scaffold(
      appBar: Appbar(title: "ORDER DETAIL"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ORDER ID:",
                  style: TextStyle(
                      fontSize: 21.0,
                      color: Color(0xfff77883),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "#${id[0]}${id[1]}${id[2]}${id[3]}${id[4]}${id[5]}",
                  style: TextStyle(
                      fontSize: 21.0,
                      color: Color(0xfff77883),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "STATUS:",
                  style: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${orderType.toUpperCase()}",
                  style: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              height: (MediaQuery.of(context).size.height) / 1.6,
              width: (MediaQuery.of(context).size.width),
              // color: Colors.grey,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer Information",
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Full Name: ",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${name}",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Contact: ",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${phone}",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email: ",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${email}",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Address: ",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Column(
                            children: [
                              Text(
                                "${address1}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${address2}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${postalCode}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${city}, ${state}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Cake Information",
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3.3,
                        child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Cake type: ",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${products[index].type}",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Name: ",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${products[index].name}",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Qty: ",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${products[index].qty}",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  if (products[index].type == "Customize Cake") ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Type: ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${products[index].customType}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Shape: ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${products[index].shape}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Size: ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${products[index].size}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Flavour: ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${products[index].flavour}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Design: ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${products[index].design}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Note: ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${products[index].note}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Price: ",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${products[index].price}",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              );
                            }),

                      ),
                      Divider(
                        color: Color(0xfff77883),
                        thickness: 4,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total: ",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "\$${total}",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if(orderType == "new")...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  fontsize: 19.0,
                  buttonsize:
                      Size((MediaQuery.of(context).size.width / 2.3), 50.0),
                  bgcolor: Color(0xfff77883),
                  text: 'Cancel',
                  onclick: () {
                    setState(() {
                      orderType = "cancelled";
                    });
                    cancelButton(uid, id, orderType);
                  },
                ),
                CustomButton(
                  fontsize: 19.0,
                  buttonsize:
                      Size((MediaQuery.of(context).size.width / 2.3), 50.0),
                  bgcolor: Color(0xfff77883),
                  text: 'Confirm',
                  onclick: () {
                    setState(() {
                      orderType = "processing";
                    });
                    confirmButton(uid, id, orderType);
                  },
                ),
              ],
            ),],
            if(orderType == 'processing')...[
              CustomButton(
                fontsize: 19.0,
                buttonsize:
                Size((MediaQuery.of(context).size.width / 2.3), 50.0),
                bgcolor: Color(0xfff77883),
                text: 'Completed',
                onclick: () {
                  setState(() {
                    orderType = "completed";
                  });
                  completeButton(uid, id, orderType);
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
  void confirmButton(uid, id, orderType) async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("order")
        .doc(id)
        .update({'orderType': orderType});

    Fluttertoast.showToast(msg: "Order confirmed");
    sendNotification(id,"confirmed");
    Navigator.pushNamed(context, "/adminHome");

  }
  void cancelButton(uid, id, orderType) async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("order")
        .doc(id)
        .update({'orderType': orderType});

    Fluttertoast.showToast(msg: "Order cancelled");
    sendNotification(id,"cancelled");
    Navigator.pushNamed(context, "/adminHome");

  }
  void completeButton(uid, id, orderType) async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("order")
        .doc(id)
        .update({'orderType': orderType});

    Fluttertoast.showToast(msg: "Order completed");
    sendNotification(id,"completed");
    Navigator.pushNamed(context, "/adminOrders");

  }
  // void sendNotification(id,status){
  //   tz.initializeTimeZones();
  //   var time = DateTime.now().add(Duration(seconds: 10));
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails('Cake dreams', 'CAKE DREAMS',
  //       channelDescription: 'Cake bakery',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker');
  //   const IOSNotificationDetails  iosPlatformChannelSpecifics=
  //   IOSNotificationDetails(
  //       presentAlert: true,presentBadge: true,presentSound: true);
  //   const NotificationDetails platformChannelSpecifics =
  //   NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iosPlatformChannelSpecifics);
  //
  //   flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'CAKE DREAMS',
  //       'Your order #${id} is ${status}',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'Cake dreams', 'CAKE DREAMS',
  //               channelDescription: 'Cake bakery')),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime);
  //
  // }
}

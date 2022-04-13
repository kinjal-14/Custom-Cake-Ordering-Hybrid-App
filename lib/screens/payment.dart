import 'package:cake_dreams/models/order_products.dart';
import 'package:cake_dreams/models/order_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../models/order_products.dart';
import '../models/order_products.dart';
import '../models/order_products.dart';
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
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var subtotal = arg['subtotal'];
    var delivery = arg['delivery'];
    var tax = arg['tax'];
    var total = arg['total'];
    var address1 = arg['address1'];
    var address2 = arg['address2'];
    var postalCode = arg['postalCode'];
    var city = arg['city'];
    var state = arg['state'];
    var products = arg['products'];

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
                              BoxShadow(color: Colors.black12, blurRadius: 5.0),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(55)),
                          ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                  child: CustomTextField(
                    hint: "Full Name",
                    secure: false,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                  child: CustomTextField(
                    hint: "ex. 1234 5678 9999 0000",
                    secure: false,
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hint: "Exp. Date",
                    secure: false,
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hint: "CVV",
                    secure: false,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButton(
                  fontsize: 18.0,
                  buttonsize:
                      Size((MediaQuery.of(context).size.width) / 1, 50.0),
                  bgcolor: Color(0xfff77883),
                  text: 'Continue',
                  onclick: () {
                    continueButton(subtotal, delivery, tax, total, address1,
                        address2, postalCode, city, state, products);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void continueButton(subtotal, delivery, tax, total, address1, address2,
      postalCode, city, state, products) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    var uuid = Uuid();
    var id = uuid.v1();
    OrderModel orderModel = OrderModel();
    orderModel.id = id;
    orderModel.subtotal = subtotal.toString();
    orderModel.delivery = delivery.toString();
    orderModel.tax = tax.toString();
    orderModel.total = total.toString();
    orderModel.address1 = address1;
    orderModel.address2 = address2;
    orderModel.postalCode = postalCode;
    orderModel.city = city;
    orderModel.state = state;
    orderModel.orderType = "new";
    for (var i = 0; i < products.length; i++) {
      print(products[i].type);
      CartModel cartModel = CartModel();
      cartModel.id = products[i].id;
      cartModel.image = products[i].image;
      cartModel.name = products[i].name;
      cartModel.qty = products[i].qty;
      cartModel.price = products[i].price;
      cartModel.type = products[i].type;
      cartModel.customType = products[i].customType;
      cartModel.shape = products[i].shape;
      cartModel.size = products[i].size;
      cartModel.flavour = products[i].flavour;
      cartModel.design = products[i].design;
      cartModel.note = products[i].note;



      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .collection("order")
          .doc(id.toString())
          .collection("products")
          .doc(products[i].id.toString())
          .set(cartModel.toMap());
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection("cart")
          .doc(products[i].id.toString())
          .delete();
    }
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("order")
        .doc(id.toString())
        .set(orderModel.toMap());
    Fluttertoast.showToast(msg: "Order has been successfully placed");
    var snackBar = SnackBar(content: Text("Order has been successfully placed"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.pushNamed(context, "/home");


  }
}

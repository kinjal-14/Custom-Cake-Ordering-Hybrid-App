import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/order_products.dart';
import '../widgets/appbar.dart';
import '../widgets/appbar_iconbutton.dart';
import '../widgets/cart_card.dart';
import '../widgets/custom_button.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  var type = "completed";
  User? user = FirebaseAuth.instance.currentUser;
  List<OrderProducts> products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts(user!.uid, type);
  }

  fetchProducts(uid, type) async {
    dynamic result = await OrderProductManager().getUserOrderList(uid, type);

    if (result == null) {
      print("Product list null");
    } else {
      setState(() {
        products = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: "ORDERS"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  fontsize: 18.0,
                  // buttonsize: Size(100.0, 58.0),
                  bgcolor: Color(0xfff77883),
                  text: 'Completed',
                  onclick: () {
                    setState(() {
                      type = "completed";
                      fetchProducts(user!.uid, type);
                    });
                  },
                ),
                CustomButton(
                  fontsize: 18.0,
                  // buttonsize: Size(100.0, 58.0),
                  bgcolor: Color(0xfff77883),
                  text: 'Processing',
                  onclick: () {
                    setState(() {
                      type = "processing";
                      fetchProducts(user!.uid, type);
                    });
                  },
                ),
                CustomButton(
                  fontsize: 18.0,
                  // buttonsize: Size(100.0, 58.0),
                  bgcolor: Color(0xfff77883),
                  text: 'Cancelled',
                  onclick: () {
                    setState(() {
                      type = "cancelled";
                      fetchProducts(user!.uid, type);
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "${type}",
                style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.4,
                child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 3),
                          child: InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, "/adminOrderDetail",
                              //     arguments: {
                              //       'id': products[index].id,
                              //       'total': products[index].total,
                              //       'uid': products[index].uid,
                              //       'address1': products[index].address1,
                              //       'address2': products[index].address2,
                              //       'city': products[index].city,
                              //       'state': products[index].state,
                              //       'postalCode': products[index].postalCode,
                              //       'orderType': products[index].orderType,
                              //       'name': products[index].name,
                              //       'phone': products[index].phone,
                              //       'email': products[index].email,
                              //       'products': products[index].products,
                              //     });
                            },
                            child: CartCard(
                              image: "cake1.jpg",
                              widget1: Text(
                                "Order id: # ${products[index].id[0]}"
                                "${products[index].id[1]}"
                                "${products[index].id[2]}"
                                "${products[index].id[3]}"
                                "${products[index].id[4]}"
                                "${products[index].id[5]}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              widget2: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Total: ",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "\$${products[index].total}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              widget3: Text(
                                "",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              widget4: SizedBox(
                                height: 0,
                              ),
                              widget5: type == "processing"
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: AppbarIconbutton(
                                          height: 40.0,
                                          width: 40.0,
                                          radius: 30.0,
                                          bg_color: Color(0xfff77883),
                                          color: Colors.white,
                                          icon_name: Icon(Icons.cancel_outlined,
                                              size: 25),
                                          onclick: () {
                                            cancelOrder(products[index].id);
                                          }),
                                    )
                                  : SizedBox(
                                      width: 0,
                                    ),
                            ),
                          ));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void cancelOrder(id) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(user!.uid)
        .collection("order")
        .doc(id.toString())
        .update({'orderType': "cancelled"});
    products.clear();
    Fluttertoast.showToast(msg: "Order cancelled");
    fetchProducts(user!.uid, type);
  }
}

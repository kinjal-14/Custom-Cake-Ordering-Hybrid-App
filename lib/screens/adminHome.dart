import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/order_products.dart';
import '../widgets/appbar_iconbutton.dart';
import '../widgets/cart_card.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  User? user = FirebaseAuth.instance.currentUser;
  List<OrderProducts> newProducts = [];
  List<OrderProducts> cancelProducts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts("new");

  }

  fetchProducts(type) async {
    dynamic result = await OrderProductManager().getOrderList(type);
    // dynamic result1 = await OrderProductManager().getCancelledOrders();
    //dyna//mic result1 = await CartProductManager().totalPrices;
    if (result == null) {
      print("Product list null");
    } else {
      setState(() {
        newProducts = result;
        // cancelProducts = result1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "HOME",
          style: TextStyle(
              fontSize: 23.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppbarIconbutton(
              height: 20.0,
              width: 20.0,
              radius: 30.0,
              bg_color: Color(0xfff77883),
              color: Colors.white,
              icon_name: Icon(Icons.shopping_cart_outlined, size: 22),
              onclick: () {
                Navigator.pushNamed(context, "/adminOrders");
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
            child: AppbarIconbutton(
                height: 30.0,
                width: 40.0,
                radius: 30.0,
                bg_color: Color(0xfff77883),
                color: Colors.white,
                icon_name: Icon(Icons.logout, size: 22),
                onclick: () {
                  FirebaseAuth.instance.signOut();
                  newProducts.clear();
                  cancelProducts.clear();
                  Navigator.pushNamed(context, "/login");
                }),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Orders",
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "New",
              style: TextStyle(
                  fontSize: 21.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              // color: Colors.black,
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView.builder(
                  itemCount: newProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 3),
                        child: InkWell(
                          onTap: () {
                            print("---------n---------");
                            print(newProducts[index].products);
                            //getUserData(newProducts[index].uid);
                            Navigator.pushNamed(context, "/adminOrderDetail",
                                arguments: {
                                  'id': newProducts[index].id,
                                  'total': newProducts[index].total,
                                  'uid': newProducts[index].uid,
                                  'address1': newProducts[index].address1,
                                  'address2': newProducts[index].address2,
                                  'city': newProducts[index].city,
                                  'state': newProducts[index].state,
                                  'postalCode': newProducts[index].postalCode,
                                  'orderType': newProducts[index].orderType,
                                  'name': newProducts[index].name,
                                  'phone': newProducts[index].phone,
                                  'email': newProducts[index].email,
                                  'products': newProducts[index].products,
                                });
                          },
                          child: CartCard(
                              image: "cake1.jpg",
                              widget1: Text(
                                "Order id: #"
                                "${newProducts[index].id[0]}"
                                "${newProducts[index].id[1]}"
                                "${newProducts[index].id[2]}"
                                "${newProducts[index].id[3]}"
                                "${newProducts[index].id[4]}"
                                "${newProducts[index].id[5]}",
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
                                    "\$${newProducts[index].total}",
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
                              widget5: SizedBox(
                                width: 0,
                              )),
                        ));
                  }),
            ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // Divider(
            //   thickness: 3,
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // Text(
            //   "Cancelled",
            //   style: TextStyle(
            //       fontSize: 21.0,
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold),
            // ),
            // Container(
            //   height: MediaQuery.of(context).size.height / 3,
            //   child: ListView.builder(
            //       itemCount: cancelProducts.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 0.0, vertical: 3),
            //             child: CartCard(
            //                 image: "cake1.jpg",
            //                 widget1: Text("Order id: #"
            //                     "${cancelProducts[index].id[0]}"
            //                     "${cancelProducts[index].id[1]}"
            //                     "${cancelProducts[index].id[2]}"
            //                     "${cancelProducts[index].id[3]}"
            //                     "${cancelProducts[index].id[4]}"
            //                     "${cancelProducts[index].id[5]}",
            //                   style: TextStyle(
            //                       fontSize: 16.0,
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //                 widget2: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                   children: [
            //                     Text(
            //                       "Total: ",
            //                       style: TextStyle(
            //                           fontSize: 16.0,
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.w400),
            //                     ),
            //                     Text(
            //                       "\$${cancelProducts[index].total}",
            //                       style: TextStyle(
            //                           fontSize: 16.0,
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.w400),
            //                     ),
            //                   ],
            //                 ),
            //                 widget3: Text(
            //                   "Orderd on : 15th march",
            //                   style: TextStyle(
            //                       fontSize: 16.0,
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //                 widget4: SizedBox(
            //                   height: 0,
            //                 ),
            //                 widget5: SizedBox(
            //                   width: 0,
            //                 )));
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}

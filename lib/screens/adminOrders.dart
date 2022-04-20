import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/order_products.dart';
import '../widgets/appbar_iconbutton.dart';
import '../widgets/cart_card.dart';
import '../widgets/custom_button.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({Key? key}) : super(key: key);

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  var type = "completed";

  List<OrderProducts> products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts(type);
  }

  fetchProducts(type) async {
    dynamic result = await OrderProductManager().getOrderList(type);

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "ORDERS",
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
              icon_name: Icon(Icons.arrow_back_ios_outlined, size: 22),
              onclick: () {
                Navigator.pushNamed(context, "/adminHome");
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
                  Navigator.pushNamed(context, "/home");
                }),
          ),
        ],
      ),
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
                      fetchProducts(type);
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
                      fetchProducts(type);
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
                      fetchProducts(type);
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
                              Navigator.pushNamed(context, "/adminOrderDetail",
                                  arguments: {
                                    'id': products[index].id,
                                    'total': products[index].total,
                                    'uid': products[index].uid,
                                    'address1': products[index].address1,
                                    'address2': products[index].address2,
                                    'city': products[index].city,
                                    'state': products[index].state,
                                    'postalCode': products[index].postalCode,
                                    'orderType': products[index].orderType,
                                    'name': products[index].name,
                                    'phone': products[index].phone,
                                    'email': products[index].email,
                                    'products': products[index].products,
                                  });
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
                                widget5: SizedBox(
                                  width: 0,
                                )),
                          ));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cake_dreams/widgets/cart_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/cart_products.dart';
import '../widgets/appbar.dart';
import '../widgets/appbar_iconbutton.dart';
import '../widgets/custom_button.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  User? user = FirebaseAuth.instance.currentUser;
  List<CartProducts> products = [];
  List<int> totals = [];
  // int t = 0;
  // var subtotalLst = [];
  //
  // // int qty = 1;
  // // double sum = 0;
  //  double total = 0;
  // var subtotal = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts(user!.uid);
    // double t = CartProductManager().calculateTotal();
    // print("t:${t}");
    // print(CartProductManager().totalPrices);
  }

  fetchProducts(id) async {
    dynamic result = await CartProductManager().getCartProductList(id);
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
    print("new::::${CartProductManager().t}");
    return Scaffold(
        appBar: Appbar(title: "SHOPPING CART"),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.pinkAccent,
          child: Column(
            children: [
              Container(
                // color: Colors.black,
                height: MediaQuery.of(context).size.height / 1.64,
                // height: 150,
                child: ListView.builder(

                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                        // subtotalLst.add(products[index].price * products[index].qty);

                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 3),
                          child: CartCard(
                            image: products[index].image,
                            widget1: Text(
                              "${products[index].name}",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            widget2: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Qty: ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),

                                Text(
                                  "${products[index].qty}",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),

                              ],
                            ),
                            widget3: Text(
                              "Price: \$${products[index].price}",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            widget4: Text(
                              "Total Price: \$${products[index].price * products[index].qty}",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            widget5: Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: AppbarIconbutton(
                                  height: 40.0,
                                  width: 40.0,
                                  radius: 30.0,
                                  bg_color: Color(0xfff77883),
                                  color: Colors.white,
                                  icon_name: Icon(Icons.delete_outline, size: 22),
                                  onclick: () {
                                    removeProduct(products[index].id);
                                  }),
                            ),
                          ));

                    }  ),

              ),
              Container(
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height / 5.8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      color: Colors.white,
                      borderOnForeground: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "\$${getTotal().subTotalString}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "\$${getTotal().deliveryFee()}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tax",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "\$${getTotal().tax()}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$${getTotal().total()}",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    fontsize: 20.0,
                    buttonsize:
                        Size((MediaQuery.of(context).size.width) / 2, 55.0),
                    bgcolor: Color(0xfff77883),
                    text: 'Order',
                    onclick: () {
                      Navigator.pushNamed(context, "/shipping");
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void removeProduct(id) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(user!.uid)
        .collection("cart")
        .doc(id.toString())
        .delete();
    products.clear();
    fetchProducts(user!.uid);
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/cart_model.dart';
import '../models/premade_products.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int qty = 1;
  User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  SingleProduct product = SingleProduct();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchProducts();
  }

  // fetchProducts() async {
  //   dynamic result = await ProductManager().getProductList();
  //   if (result == null) {
  //     print("Product list null");
  //   } else {
  //     setState(() {
  //       products = result;
  //     });
  //   }
  // }
  fetchProduct(int id) {
    FirebaseFirestore.instance
        .collection("products")
        .doc("${id}")
        .get()
        .then((value) {
      this.product = SingleProduct.fromMap(value.data());
      if (this.mounted) {
        // check whether the state object is in tree
        setState(() {
          // make changes here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as int;
    // print(productId);
    fetchProduct(productId);
    // print("id ${product}");
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Container(
            height: (MediaQuery.of(context).size.height),
            width: (MediaQuery.of(context).size.width),
          ),
          Positioned(
            child: Image.asset(
              "assets/images/${product.image}",
              // color: Colors.grey.withOpacity(1),
              colorBlendMode: BlendMode.modulate,
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height) / 1.7,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 45,
                width: 45,
                decoration: new BoxDecoration(
                    color: Color(0xfff77883),
                    borderRadius: BorderRadius.circular(30.0)),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 18,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 50,
              top: (MediaQuery.of(context).size.height) / 1.55,
              child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      height: 30,
                      width: (MediaQuery.of(context).size.width),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${product.name}",
                            style: TextStyle(
                                fontSize: 28.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Container(
                      // height: 40,
                      width: (MediaQuery.of(context).size.width) / 1.1,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${product.desc}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Size: ${product.size}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Calories: ${product.calories}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Price: \$${product.price}",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Rating:",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 00.0),
                    child: Container(
                      height: 55,
                      width: (MediaQuery.of(context).size.width) / 1.2,
                      decoration: new BoxDecoration(
                          color: Color(0xfff77883),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    primary: Colors.white,
                                    minimumSize: Size(6, 6),
                                    // shape: StadiumBorder()
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (qty <= 1) {
                                        qty = 1;
                                      } else {
                                        qty = qty - 1;
                                      }
                                    });
                                  },
                                  child: const Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${qty}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    primary: Colors.white,
                                    minimumSize: Size(6, 6),
                                    // shape: StadiumBorder()
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (qty >= 10) {
                                        qty = 10;
                                      } else {
                                        qty = qty + 1;
                                      }
                                    });
                                  },
                                  child: const Text(
                                    '+',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                addToCart(
                                    product.id,
                                    product.image,
                                    product.name,
                                    qty,
                                    product.price,
                                    "Pre-Made Cake");
                              },
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void addToCart(id, image, name, qty, price, type) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    CartModel cartModel = CartModel();
    cartModel.id = id;
    cartModel.image = image;
    cartModel.name = name;
    cartModel.qty = qty;
    cartModel.price = price;
    cartModel.type = type;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("cart")
        .doc(id.toString())
        .set(cartModel.toMap());
     Fluttertoast.showToast(msg: "Product Added to Cart");
   
  }
}

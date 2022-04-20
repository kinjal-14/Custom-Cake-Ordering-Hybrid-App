import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

import '../models/cart_model.dart';
import '../models/premade_products.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

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
              bottom: 30,
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
                                  Row(
                                    children: [
                                      Text(
                                        "Rating:",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Color(0xfff77883),
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Share Cake Information: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: new BoxDecoration(
                                            color: Color(0xfff77883),
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.share,
                                            size: 15,
                                          ),
                                          color: Colors.white,
                                          onPressed: () {
                                            String message =
                                                "------Cake Dreams-------"
                                                "\nName: ${product.name}"
                                                "\nDescription: ${product.desc}"
                                                "\nSize: ${product.size}"
                                                "\nCalories: ${product.calories}"
                                                "\nPrice: \$${product.price}";
                                            List<String> recipents = [];

                                            _sendSMS(message, recipents);

                                            // await launch('sms:+1(514)992-7751?body=hi');
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
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

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  void addToCart(id, image, name, qty, price, type) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    CartModel cartModel = CartModel();
    cartModel.id = id.toString();
    cartModel.image = image;
    cartModel.name = name;
    cartModel.qty = qty;
    cartModel.price = price;
    cartModel.type = type;
    cartModel.customType = "";
    cartModel.shape = "";
    cartModel.size = "";
    cartModel.flavour = "";
    cartModel.design = "";
    cartModel.note = "";

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("cart")
        .doc(id.toString())
        .set(cartModel.toMap());
    Fluttertoast.showToast(msg: "Product Added to Cart");
  }
}

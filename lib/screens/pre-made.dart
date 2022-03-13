import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cake_dreams/models/premade_products.dart';
import '../widgets/appbar_iconbutton.dart';
import '../widgets/customize_card.dart';

class PreMade extends StatefulWidget {
  const PreMade({Key? key}) : super(key: key);

  @override
  State<PreMade> createState() => _PreMadeState();
}

class _PreMadeState extends State<PreMade> {
  User? user = FirebaseAuth.instance.currentUser;
  var cartpage = "/login";
  // final List<PreMadeProducts> products = PreMadeProducts.products;
  List<PreMadeProducts> products = [];

  String selectedValue = 'Name';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Name"), value: "Name"),
      DropdownMenuItem(child: Text("Price"), value: "Price"),
      DropdownMenuItem(child: Text("Size"), value: "Size"),
      // DropdownMenuItem(child: Text("England"),value: "England"),
    ];
    return menuItems;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    dynamic result = await ProductManager().getProductList(selectedValue.toLowerCase());
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
          "PRE-MADE CAKES",
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
              icon_name: Icon(Icons.arrow_back_ios_outlined, size: 19),
              onclick: () {
                Navigator.pushNamed(context, "/home");
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppbarIconbutton(
              height: 55.0,
              width: 40.0,
              radius: 30.0,
              bg_color: Color(0xfff77883),
              color: Colors.white,
              icon_name: Icon(Icons.shopping_cart_outlined, size: 19),
              onclick: () {
                if (user != null) {
                  cartpage = "/cart";
                } else {
                  cartpage = "/login";
                }
                Navigator.pushNamed(context, cartpage);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sort & Filter : ",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                    width: 120.0,
                    height: 60.0,
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffd3d3d3), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffd3d3d3), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffd3d3d3), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        dropdownColor: Colors.white,
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            fetchProducts();
                          });
                        },
                        items: dropdownItems)),
              ],
            ),
          ),
          Container(
            // color: Colors.grey,
            height: (MediaQuery.of(context).size.height) / 1.35,
            width: (MediaQuery.of(context).size.width) / 1,
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: (MediaQuery.of(context).size.height) / 5.53,
                      // width: (MediaQuery.of(context).size.width) / 2.5,
                      // child: Card(
                      //   color: Colors.white,
                      child: InkWell(

                        onTap: () => {
                          if (user != null)
                            {
                              Navigator.pushNamed(context, "/detail",
                                  arguments: products[index].id)
                            }
                          else
                            {}
                        },
                        child: CustomizeCard(
                          image: "assets/images/" + products[index].image,
                          name: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(products[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.5)),
                              Text("\$" + products[index].price.toString() + "|" + products[index].size.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.5)),
                            ],
                          ),
                          image_fit: BoxFit.fill,
                          image_height:
                              (MediaQuery.of(context).size.height) / 5.59,
                          image_width: (MediaQuery.of(context).size.width) / 1,
                          // font_size: 16.0,
                          // font_weight: FontWeight.w600,
                        ),
                      )
                      // ),
                      );
                }),
          ),
        ],
      ),
    );
  }
}

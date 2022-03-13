import 'package:cake_dreams/widgets/appbar_iconbutton.dart';
import 'package:cake_dreams/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/premade_products.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  var accountpage = "/login";
  var cartpage = "/login";
  var customizepage = "/login";

  // final List<PreMadeProducts> products = PreMadeProducts.products;
  List<PreMadeProducts> products = [];
  final List<String> imageList = [
    "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  final List<String> imageeList = [
    "assets/images/home.jpg",
    "assets/images/homecake.jpg",
    "assets/images/splash.jpeg",
    "assets/images/user.jpeg",
    "assets/images/splashLogo.png",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    dynamic result = await ProductManager().getProductList("name");
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
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Container(
            height: (MediaQuery.of(context).size.height),
            width: (MediaQuery.of(context).size.width),
          ),
          Positioned(
            // top: 0,
            // bottom: 500,
            child: Image.asset(
              "assets/images/home.jpg",
              color: Colors.grey.withOpacity(1),
              colorBlendMode: BlendMode.modulate,
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height) / 2,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppbarIconbutton(
                    height: 50.0,
                    width: 50.0,
                    radius: 30.0,
                    bg_color: Color(0xfff77883),
                    color: Colors.white,
                    icon_name: Icon(Icons.person_outlined),
                    onclick: () {
                      if (user != null) {
                        accountpage = "/account";
                      } else {
                        accountpage = "/login";
                      }
                      Navigator.pushNamed(context, accountpage);
                    },
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width) / 1.5,
                  ),
                  AppbarIconbutton(
                    height: 50.0,
                    width: 50.0,
                    radius: 30.0,
                    bg_color: Color(0xfff77883),
                    color: Colors.white,
                    icon_name: Icon(Icons.shopping_cart_outlined),
                    onclick: () {
                      if (user != null) {
                        cartpage = "/cart";
                      } else {
                        cartpage = "/login";
                      }
                      Navigator.pushNamed(context, cartpage);
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 230,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "How Would You\nLike To Order?",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
              top: (MediaQuery.of(context).size.height) / 2.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30.0,
                    ),
                    CustomButton(
                      fontsize: 18.0,
                      buttonsize: Size(100.0, 70.0),
                      bgcolor: Color(0xfff77883),
                      text: 'Pre-Made\nCake',
                      onclick: () {
                        Navigator.pushNamed(context, "/pre-made");
                      },
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 6.3,
                    ),
                    CustomButton(
                      fontsize: 18.0,
                      buttonsize: Size(100.0, 70.0),
                      bgcolor: Color(0xfff77883),
                      text: 'Customize\nCake',
                      onclick: () {
                        if (user != null) {
                          customizepage = "/customize";
                        } else {
                          customizepage = "/login";
                        }
                        Navigator.pushNamed(context, customizepage);
                      },
                    ),
                  ],
                ),
              )),
          Positioned(
              bottom: 350,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Available Now",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 2.6,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/pre-made");
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xfff77883),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
              bottom: 90.0,
              // top: 600.0,
              left: 0.0,
              right: 0.0,
              child: SizedBox(
                height: (MediaQuery.of(context).size.height / 3.5),
                child: ListView.builder(
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 00.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: InkWell(
                          onTap: () => {
                            if(user != null){
                              Navigator.pushNamed(context, "/detail",
                                  arguments: products[index].id)
                            }
                            else{

                            }

                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 4.0),
                            width: MediaQuery.of(context).size.width / 2.4,
                            height: (MediaQuery.of(context).size.height / 3.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28.0),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/" + products[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )

              // child: Container(
              //   height: (MediaQuery.of(context).size.height / 3),
              //   width: (MediaQuery.of(context).size.width),
              //   child: ListView(
              //     shrinkWrap: true,
              //     children: [
              //       CarouselSlider(
              //         items: [
              //           //1st Image of Slider
              //           Container(
              //             margin: EdgeInsets.all(6.0),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(8.0),
              //               image: DecorationImage(
              //                 image: AssetImage(
              //                   "assets/images/cake17.jpg",
              //                 ),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //
              //           //2nd Image of Slider
              //           Container(
              //             margin: EdgeInsets.all(6.0),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(8.0),
              //               image: DecorationImage(
              //                 image: AssetImage("assets/images/cake19.jpg"),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //
              //           //3rd Image of Slider
              //           Container(
              //             margin: EdgeInsets.all(6.0),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(8.0),
              //               image: DecorationImage(
              //                 image: AssetImage("assets/images/cake4.jpg"),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //
              //           //4th Image of Slider
              //           Container(
              //             margin: EdgeInsets.all(6.0),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(8.0),
              //               image: DecorationImage(
              //                 image: AssetImage("assets/images/cake2.jpg"),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //
              //           //5th Image of Slider
              //           Container(
              //             margin: EdgeInsets.all(6.0),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(8.0),
              //               image: DecorationImage(
              //                 image: AssetImage("assets/images/cake1.jpg"),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ],
              //
              //         //Slider Container properties
              //         options: CarouselOptions(
              //           height: 250.0,
              //           enlargeCenterPage: true,
              //           autoPlay: true,
              //           aspectRatio: 16 / 9,
              //           autoPlayCurve: Curves.fastOutSlowIn,
              //           enableInfiniteScroll: true,
              //           autoPlayAnimationDuration: Duration(milliseconds: 800),
              //           viewportFraction: 0.8,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // child: Container(
              //   margin: EdgeInsets.all(15),
              //   child: CarouselSlider.builder(
              //     itemCount: imageList.length,
              //     options: CarouselOptions(
              //       enlargeCenterPage: true,
              //       height: 300,
              //       autoPlay: true,
              //       autoPlayInterval: Duration(seconds: 3),
              //       reverse: false,
              //       aspectRatio: 5.0,
              //     ),
              //     itemBuilder: (context, i, id){
              //       //for onTap to redirect to another screen
              //       return GestureDetector(
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(15),
              //               border: Border.all(color: Colors.white,)
              //           ),
              //           //ClipRRect for image border radius
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(15),
              //             child: Image.network(
              //               imageList[i],
              //               width: 500,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //         onTap: (){
              //           var url = imageList[i];
              //           print(url.toString());
              //         },
              //       );
              //     },
              //   ),
              // ),
              )
        ],
      ),
    );
  }
}

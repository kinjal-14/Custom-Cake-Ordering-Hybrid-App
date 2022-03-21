import 'package:cake_dreams/models/customize_category.dart';
import 'package:cake_dreams/models/customize_maincategory.dart';
import 'package:cake_dreams/widgets/appbar_iconbutton.dart';
import 'package:cake_dreams/widgets/custom_button.dart';
import 'package:cake_dreams/widgets/customize_card.dart';
import 'package:cake_dreams/widgets/customize_greycard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import '../models/cart_model.dart';

class Customize extends StatefulWidget {
  const Customize({Key? key}) : super(key: key);

  @override
  _CustomizeState createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize> {
  int counter = 0;
  int qty = 1;
  int price = 100;
  var shapecolor = Color(0xff999999);
  var sizecolor = Color(0xff999999);
  var flavourcolor = Color(0xff999999);
  var designcolor = Color(0xff999999);
  var type = "Regular";
  var shape = "Hexagon";
  var size = "0.5 lb";
  var flavour = "Almond";
  var design = "Makeup";
  var selectedOptions = [];
  List<Category> categories = Category.custom_types;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController noteController = new TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final List<MainCategory> maincategory = MainCategory.custom_maincategory;
    void incrementCounter() {
      setState(() {
        if (counter < 5) {
          counter++;

          print("counter::$counter");
          if (counter == 1) {
            shapecolor = Color(0xfff77883);
            categories = Category.custom_shapes;
          }
          if (counter == 2) {
            sizecolor = Color(0xfff77883);
            categories = Category.custom_sizes;
          }
          if (counter == 3) {
            flavourcolor = Color(0xfff77883);
            categories = Category.custom_falvours;
          }
          if (counter == 4) {
            designcolor = Color(0xfff77883);
            categories = Category.custom_designs;
          }
          if (counter == 5) {
            selectedOptions.add(type);
            selectedOptions.add(shape);
            selectedOptions.add(size);
            selectedOptions.add(flavour);
            selectedOptions.add(design);

          }
        } else {
          print("added to cart");
        }
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height),
            width: (MediaQuery.of(context).size.width),
          ),
          Positioned(
            child: Image.asset(
              "assets/images/home.jpg",
              color: Colors.grey.withOpacity(1),
              colorBlendMode: BlendMode.modulate,
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height) / 3,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppbarIconbutton(
                      height: 40.0,
                      width: 40.0,
                      radius: 30.0,
                      bg_color: Color(0xfff77883),
                      color: Colors.white,
                      icon_name: Icon(Icons.house_outlined, size: 22),
                      onclick: () {Navigator.pushNamed(context, "/home");}),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width) / 1.4,
                  ),
                  AppbarIconbutton(
                      height: 40.0,
                      width: 40.0,
                      radius: 30.0,
                      bg_color: Color(0xfff77883),
                      color: Colors.white,
                      icon_name: Icon(Icons.shopping_cart_outlined, size: 19),
                      onclick: () {}),
                ],
              ),
            ),
          ),
          Positioned(
            top: 140,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Customize\nCake",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (counter < 5) ...[
            Positioned(
                top: (MediaQuery.of(context).size.height) / 3.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        fontsize: 16.0,
                        buttonsize: Size(50.0, 55.0),
                        bgcolor: Color(0xfff77883),
                        text: 'Type',
                        onclick: () {},
                      ),
                      CustomButton(
                        fontsize: 16.0,
                        buttonsize: Size(60.0, 55.0),
                        bgcolor: shapecolor,
                        text: 'Shape',
                        onclick: () {},
                      ),
                      CustomButton(
                        fontsize: 16.0,
                        buttonsize: Size(60.0, 55.0),
                        bgcolor: sizecolor,
                        text: 'Size',
                        onclick: () {},
                      ),
                      CustomButton(
                        fontsize: 16.0,
                        buttonsize: Size(60.0, 55.0),
                        bgcolor: flavourcolor,
                        text: 'Flavour',
                        onclick: () {},
                      ),
                      CustomButton(
                        fontsize: 16.0,
                        buttonsize: Size(60.0, 55.0),
                        bgcolor: designcolor,
                        text: 'Design',
                        onclick: () {},
                      ),
                    ],
                  ),
                )),
            Positioned(
              bottom: 30,
              child: Container(
                width: (MediaQuery.of(context).size.width),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: CustomButton(
                    fontsize: 19.0,
                    buttonsize: Size(100.0, 58.0),
                    bgcolor: Color(0xfff77883),
                    text: 'Continue',
                    onclick: () {
                      incrementCounter();
                    },
                  ),
                ),
              ),
            ),
            Positioned(
                top: (MediaQuery.of(context).size.height) / 2.8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                  child: Container(
                    // color: Colors.grey,
                    height: (MediaQuery.of(context).size.height) / 1.9,
                    width: (MediaQuery.of(context).size.width) / 1,
                    child: GridView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10),
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height:
                                  (MediaQuery.of(context).size.height) / 5.53,
                              // width: (MediaQuery.of(context).size.width) / 2.5,
                              // child: Card(
                              //   color: Colors.white,
                              child: GestureDetector(

                                onTap: (){setState(() {

                                  if(counter == 0){
                                    type = categories[index].name;
                                    print(type);
                                    Fluttertoast.showToast(msg: "Selected type : ${type}");
                                    // var snackBar = SnackBar(content: Text("Selected type : ${type}"));
                                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                  if(counter == 1){
                                    shape = categories[index].name;
                                    Fluttertoast.showToast(msg: "Selected shape : ${shape}");
                                  }
                                  if(counter == 2){
                                    size = categories[index].name;
                                    Fluttertoast.showToast(msg: "Selected size : ${size}");
                                  }
                                  if(counter == 3){
                                    flavour = categories[index].name;
                                    Fluttertoast.showToast(msg: "Selected flavour : ${flavour}");
                                  }
                                  if(counter == 4){
                                    design = categories[index].name;
                                    Fluttertoast.showToast(msg: "Selected design : ${design}");
                                  }

                                });},
                                child: CustomizeCard(
                                  image: categories[index].image,
                                  name: Text(categories[index].name,style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 16.0)),
                                  image_fit: BoxFit.fill,
                                  image_height:
                                      (MediaQuery.of(context).size.height) / 5.59,
                                  image_width:
                                      (MediaQuery.of(context).size.width) / 1,
                                  // font_size: 16.0,
                                  // font_weight: FontWeight.w600,
                                ),
                              )
                              // ),
                              );
                        }),
                  ),
                ))
          ] else ...[
            Positioned(
              bottom: 30,
              child: Container(
                width: (MediaQuery.of(context).size.width),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        fontsize: 19.0,
                        buttonsize: Size(170.0, 45.0),
                        bgcolor: Color(0xfff77883),
                        text: 'Add to Cart',
                        onclick: () {
                          addToCart(
                              "Customized cake",
                              qty,
                              price,
                              "Customize Cake",
                          type,shape,size,design,flavour,noteController.text);
                        },
                      ),
                      CustomButton(
                        fontsize: 19.0,
                        buttonsize: Size(170.0, 45.0),
                        bgcolor: Color(0xfff77883),
                        text: 'Cancel',
                        onclick: () {
                          setState(() {
                            counter = 0;
                            categories = Category.custom_types;
                            shapecolor = Color(0xff999999);
                            sizecolor = Color(0xff999999);
                            flavourcolor = Color(0xff999999);
                            designcolor = Color(0xff999999);
                            type = "Regular";
                            shape = "Hexagon";
                            size = "0.5 lb";
                            flavour = "Almond";
                            design = "Makeup";
                            selectedOptions.clear();
                            qty = 1;
                            price = 100;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height) / 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text("Selected Options",
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height) / 2.7,
              bottom: 260.0,
              left: 20.0,
              right: 20.0,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: maincategory.length,
                  itemBuilder: (context, index) {
                    return CustomizeGreyCard(
                      width: (MediaQuery.of(context).size.width / 1.09),
                      height: 45.0,
                      text1: maincategory[index].name,
                      text2: selectedOptions[index],
                      font_size: 17.0,
                    );
                  }),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height) / 1.40,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text("Notes",
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Positioned(
              bottom: 170.0,
              top: (MediaQuery.of(context).size.height) / 1.32,
              left: 5.0,
              right: 5.0,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      onSaved: (value) {
                        noteController.text = value!;
                      },

                      controller: noteController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          fontSize: 17.0, height: 1.0, color: Colors.black),
                      decoration: InputDecoration(

                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black),
                            // borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black),
                            // borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Enter Note'),
                    ),
                  )),
            ),
            Positioned(
              bottom: 90,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomizeGreyCard(
                      width: (MediaQuery.of(context).size.width / 2.2),
                      height: 45.0,
                      text1: "PRICE:",
                      text2: '\$${price}',
                      font_size: 17.0,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 7),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                            primary: Color(0xfff77883),
                            minimumSize: Size(10, 30),
                            // shape: StadiumBorder()
                          ),
                          onPressed: () {setState(() {
                            if(qty <= 1){
                              qty = 1;
                            }
                            else{
                            qty = qty - 1;}
                          });},
                          child: const Text(
                            '-',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                         " ${qty}",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                            primary: Color(0xfff77883),
                            minimumSize: Size(10, 30),
                            // shape: StadiumBorder()
                          ),
                          onPressed: () {setState(() {
                            if(qty >= 10){
                              qty = 10;
                            }
                            else{
                            qty = qty + 1;}
                          });},
                          child: const Text(
                            '+',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
  void addToCart(name, qty, price, type, customType, shape, size, flavour, design, note) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    var uuid = Uuid();
    var id =  uuid.v1();
    var image = "cake_four.jpeg";
    CartModel cartModel = CartModel();
    cartModel.id = id;
    cartModel.image = image;
    cartModel.name = name;
    cartModel.qty = qty;
    cartModel.price = price;
    cartModel.type = type;
    cartModel.customType = customType;
    cartModel.shape = shape;
    cartModel.size = size;
    cartModel.flavour = flavour;
    cartModel.design = design;
    cartModel.note = note;



    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("cart")
        .doc(id.toString())
        .set(cartModel.toMap());
    Fluttertoast.showToast(msg: "Product Added to Cart");

  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

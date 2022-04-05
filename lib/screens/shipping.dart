import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/textfield.dart';
import 'package:http/http.dart' as http;

class Shipping extends StatefulWidget {
  const Shipping({Key? key}) : super(key: key);

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController address1Controller = new TextEditingController();
  final TextEditingController address2Controller = new TextEditingController();
  final TextEditingController postalCodeController =
      new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController stateController = new TextEditingController();
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var subtotal = arg['subtotal'];
    var delivery = arg['delivery'];
    var tax = arg['tax'];
    var total = arg['total'];
    var products = arg['products'];

    return Scaffold(
      appBar: Appbar(title: "SHIPPING"),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          // color: Colors.amber,
          height: (MediaQuery.of(context).size.height) / 1.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 5.0),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(55))),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/cake4.jpg"),
                            radius: 60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: CustomTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Address 1");
                            }

                            return null;
                          },
                          hint: "Address 1",
                          secure: false,
                          controller: address1Controller,
                          // keyboardtype: TextInputType.emailAddress,
                          onSaved: (value) {
                            address1Controller.text = value!;
                          },
                          action: TextInputAction.next,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: CustomTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Address2");
                            }

                            return null;
                          },
                          hint: "Address 2",
                          secure: false,
                          controller: address2Controller,
                          // keyboardtype: TextInputType.emailAddress,
                          onSaved: (value) {
                            address2Controller.text = value!;
                          },
                          action: TextInputAction.next,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: CustomTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Postal Code");
                            }
                            return null;
                          },
                          hint: "Postal Code",
                          secure: false,
                          controller: postalCodeController,
                          // keyboardtype: TextInputType.emailAddress,
                          onSaved: (value) {
                            postalCodeController.text = value!;
                          },
                          action: TextInputAction.next,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: CustomTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your City");
                            }
                            return null;
                          },
                          hint: "City",
                          secure: false,
                          controller: cityController,
                          // keyboardtype: TextInputType.emailAddress,
                          onSaved: (value) {
                            cityController.text = value!;
                          },
                          action: TextInputAction.next,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: CustomTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your State");
                            }
                            return null;
                          },
                          hint: "State",
                          secure: false,
                          controller: stateController,
                          // keyboardtype: TextInputType.emailAddress,
                          onSaved: (value) {
                            stateController.text = value!;
                          },
                          action: TextInputAction.done,
                        )),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                            primary: Color(0xfff77883),
                            minimumSize:
                                Size((MediaQuery.of(context).size.width), 55.0),
                            shape: StadiumBorder()),
                        onPressed: () async{
                          await buy(subtotal, delivery, tax,total, address1Controller.text, address2Controller.text, postalCodeController.text,cityController.text, stateController.text,products);

                        },
                        child: const Text('Buy'),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }
  Future <void> buy(subtotal, delivery, tax, total, address1, address2, postalCode, city, state, products) async {
    if (_formKey.currentState!.validate()) {
      try{
          paymentIntentData = await createPaymentIntent("${total.toInt()}", 'cad');
        if (paymentIntentData != null) {
          await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                applePay: false,
                googlePay: false,
                testEnv: true,
                merchantCountryCode: 'CA',
                merchantDisplayName: 'CakeDreams',
                customerId: paymentIntentData!['customer'],
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
              ));
          displayPaymentSheet(subtotal, delivery, tax, total, address1,
              address2, postalCode, city, state, products);
        }

      }catch(e){
        print('exception'+e.toString());
      }

    }
  }

  displayPaymentSheet(subtotal, delivery, tax, total, address1,
      address2, postalCode, city, state, products) async {
    try {
      print("payment sheet created");
      await Stripe.instance.presentPaymentSheet();
      print("after payment sheet presented");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Paid successfully")));
      order(subtotal, delivery, tax, total, address1,
          address2, postalCode, city, state, products);
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }
  createPaymentIntent(String amount, String currency)async{
    try{
     Map<String, dynamic> body = {
       'amount' : calculateAmount(amount),
       'currency': currency,
       'payment_method_types[]': 'card'
     };
     var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
      body: body,
      headers: {
       'Authorization': 'Bearer sk_test_51KkDW2B01bPVQ0Ks37VSfzJd6Gpo70m10zANXJTQ5psUZptJVRRayu8JtUIbOJ0NeTSvslNtZ50xloJAe1R8YJqC00RqgH8xG0',
        'Content-Type': 'application/x-www-form-urlencoded'
      }
     );
     return jsonDecode(response.body.toString());
    }catch(e){
      print('exception'+e.toString());
    }
  }
  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
  void order(subtotal, delivery, tax, total, address1, address2,
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

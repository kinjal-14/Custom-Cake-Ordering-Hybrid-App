import 'dart:convert';

import 'package:cake_dreams/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_products.dart';

class OrderProducts {
  String id,
      total,
      uid,
      address1,
      address2,
      city,
      state,
      postalCode,
      orderType,
      name,
      phone,
      email;
  List<CartProducts> products;
  OrderProducts({
    required this.id,
    required this.uid,
    required this.total,
    required this.orderType,
    required this.state,
    required this.city,
    required this.address1,
    required this.postalCode,
    required this.address2,
    required this.name,
    required this.phone,
    required this.email,
    required this.products,
  });
}

List<OrderProducts> order_products = [];
List<OrderProducts> cancelled_order_products = [];
List<CartProducts> productsNew = [];


class OrderProductManager {
  Future getOrderList(orderType) async {
    final _fireStore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _fireStore.collection('users').get();

    final userIds = querySnapshot.docs.map((doc) => doc.get('uid')).toList();
    final userData = querySnapshot.docs.map((doc) => doc.data()).toList();

    order_products.clear();
    for (var i = 0; i < userIds.length; i++) {
      final CollectionReference productsItems = FirebaseFirestore.instance
          .collection('users')
          .doc('${userIds[i]}')
          .collection("order");

      try {
        cancelled_order_products.clear();
        var snapshot = await productsItems.get();
        snapshot.docs.forEach((element) async {
          Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;

          if (data != null) {
            var item = OrderProducts(
                id: "0",
                total: "no",
                uid: "h",
                address1: "",
                address2: "",
                postalCode: "",
                city: "",
                orderType: "",
                state: "",
                name: "",
                phone: "",
                email: "",
                products: []);
            if (data['orderType'] == orderType) {
              item.id = data['id'];
              item.total = data['total'];
              item.address1 = data['address1'];
              item.address2 = data['address2'];
              item.city = data['city'];
              item.state = data['state'];
              item.postalCode = data['postalCode'];
              item.orderType = data['orderType'];
              item.uid = userIds[i];
              Map<String, dynamic>? user = userData[i] as Map<String, dynamic>?;
              item.name = user!['name'];
              item.phone = user['phone'];
              item.email = user['email'];
              // products.clear();
              // item.products.clear();
              //dynamic result = getProductList(userIds[i], data["id"]);
              // productsNew = result;
              item.products = products;
              // print("item.products");
              // print(item.products);
              order_products.add(item);
              // products.clear();
              // item.products.clear();
            }
            // if(data['orderType'] == 'cancelled'){
            //   item.id = data['id'];
            //   item.total = data['total'];
            //   cancelled_order_products.add(item);
            // }

          } else {
            print("error:");
          }
        });

        // return (order_products);
      } catch (e) {
        print("Error : ${e.toString()}");
        // return [];
      }
    }
    return order_products;
  }

  List<CartProducts> products = [];
  getProductList(uid, id) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var snapshot = await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("order")
        .doc(id)
        .collection("products")
        .get();
    try {
      products.clear();

      snapshot.docs.forEach((element) {
        Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
        if (data != null) {
          var item = CartProducts(
              name: 'hello',
              price: 14,
              image: 'assets/images/cake1.jpg',
              id: "0",
              qty: 1,
              customType: "no",
              type: "no",
              shape: "no",
              size: "no",
              flavour: "no",
              design: "no",
              note: "no");
          item.name = data['name'];
          item.price = data['price'];
          item.image = data['image'];
          item.id = data['id'];
          item.qty = data['qty'];
          item.customType = data['customType'];
          item.design = data['design'];
          item.flavour = data['flavour'];
          item.note = data['note'];
          item.shape = data['shape'];
          item.size = data['size'];
          item.type = data['type'];

          products.add(item);
        } else {
          print("error:");
        }
      });

      return (products);
    } catch (e) {
      print("Error : ${e.toString()}");
      return [];
    }
  }
  List<OrderProducts> user_order_products = [];
  // UserModel currentUser = UserModel();
  Future getUserOrderList(uid, orderType) async {
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(uid)
    //     .get()
    //     .then((value) {
    //   currentUser = UserModel.fromMap(value.data());
    // });
    user_order_products.clear();

    final CollectionReference productsItems = FirebaseFirestore.instance
        .collection('users')
        .doc('${uid}')
        .collection("order");

    try {
      var snapshot = await productsItems.get();
      snapshot.docs.forEach((element) async {
        Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;

        if (data != null) {
          var item = OrderProducts(
              id: "0",
              total: "no",
              uid: "h",
              address1: "",
              address2: "",
              postalCode: "",
              city: "",
              orderType: "",
              state: "",
              name: "",
              phone: "",
              email: "",
              products: []);
          if (data['orderType'] == orderType) {
            item.id = data['id'];
            item.total = data['total'];
            item.address1 = data['address1'];
            item.address2 = data['address2'];
            item.city = data['city'];
            item.state = data['state'];
            item.postalCode = data['postalCode'];
            item.orderType = data['orderType'];
            item.uid = uid;
            item.name = "";
            item.phone = "";
            item.email = "";
            item.products = [];

            user_order_products.add(item);

          }
        } else {
          print("error:");
        }
      });

       // return (user_order_products);
    } catch (e) {
      print("Error : ${e.toString()}");
       // return [];
    }
    return user_order_products;

}}
